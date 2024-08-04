#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <chrono>
#include <thread>
#include <libssh/libssh.h>
#include <libssh/sftp.h>
#include <zip.h>
#include <fcntl.h>
#include <fstream>
#include <optional>

using namespace std;
using namespace std::chrono;

const string REMOTE_HOST1 = "127.0.0.1";
const string REMOTE_HOST2 = "127.0.0.1";
const string REMOTE1_COLLECT_DIR = "/tmp/remote1/files/";
const string REMOTE1_ARCHIVE_PATH = "/tmp/remote1/archive.zip";
const string REMOTE2_DEST_PATH = "/tmp/remote2/transferred.zip";
const string LOCAL_PRIVATE_KEY_PATH = "/home/kali/.ssh/id_rsa";
const string ZIP_PASSPHRASE = "zip_archive_passphrase";
const string LOCAL_PATH = "/tmp/local/";
const string LOCAL_ZIP_PATH = "/tmp/local/local_zip.zip";
const int CHECK_INTERVAL = 5;

// Debug flag
bool debug_mode = false;

// Debug print function
void debugprint(const string &message)
{
    if (debug_mode)
    {
        cout << message << endl;
    }
}

ssh_session create_ssh_session(const string &host)
{
    ssh_session session = ssh_new();
    if (session == NULL)
        return NULL;

    ssh_options_set(session, SSH_OPTIONS_USER, "kali");
    ssh_options_set(session, SSH_OPTIONS_HOST, host.c_str());

    // Load the private key
    if (ssh_options_set(session, SSH_OPTIONS_IDENTITY, LOCAL_PRIVATE_KEY_PATH.c_str()) != SSH_OK)
    {
        cerr << "Error setting private key: " << ssh_get_error(session) << endl;
        ssh_free(session);
        return NULL;
    }

    if (ssh_connect(session) != SSH_OK)
    {
        cerr << "Error connecting to " << host << ": " << ssh_get_error(session) << endl;
        ssh_free(session);
        return NULL;
    }

    // Check authentication
    if (ssh_userauth_publickey_auto(session, NULL, NULL) != SSH_AUTH_SUCCESS)
    {
        cerr << "Error authenticating with public key: " << ssh_get_error(session) << endl;
        ssh_disconnect(session);
        ssh_free(session);
        return NULL;
    }

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
            new_files.push_back(REMOTE1_COLLECT_DIR + attributes->name);
        }
        sftp_attributes_free(attributes);
    }

    sftp_closedir(dir);

    return !new_files.empty();
}

bool create_zip_from_files(const vector<string> &files, const string &zip_path, const string &password)
{
    int error;
    zip_t *archive = zip_open(zip_path.c_str(), ZIP_CREATE, &error);
    if (!archive)
    {
        cerr << "Error creating ZIP archive: " << zip_strerror(archive) << endl;
        return false;
    }

    for (const auto &file : files)
    {
        zip_source_t *source = zip_source_file(archive, file.c_str(), 0, 0);
        if (source == NULL)
        {
            cerr << "Error adding file to ZIP archive: " << zip_strerror(archive) << endl;
            zip_close(archive);
            return false;
        }
        string filename = file.substr(file.find_last_of("/") + 1);
        zip_file_add(archive, filename.c_str(), source, ZIP_FL_ENC_UTF_8);
        zip_file_set_encryption(archive, zip_name_locate(archive, filename.c_str(), ZIP_FL_ENC_UTF_8), ZIP_EM_AES_256, password.c_str());
    }

    if (zip_close(archive) < 0)
    {
        std::cerr << "Error closing ZIP archive: " << zip_strerror(archive) << std::endl;
        return false;
    }

    return true;
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

bool download_file(sftp_session sftp, const string &remote_file, const string &local_file)
{
    sftp_file file = sftp_open(sftp, remote_file.c_str(), O_RDONLY, 0);
    if (file == NULL)
    {
        cerr << "Failed to open file on RemoteHost1: " << remote_file << endl;
        return false;
    }
    ofstream ofs(local_file, ios::binary);
    if (!ofs.is_open())
        return false;

    char buffer[1024];
    int nbytes;
    while ((nbytes = sftp_read(file, buffer, sizeof(buffer))) > 0)
    {
        ofs.write(buffer, nbytes);
    }

    sftp_close(file);
    ofs.close();

    return true;
}

bool download_files(sftp_session sftp, const vector<string> &remote_files, const string &local_dir)
{
    for (const auto &remote_file : remote_files)
    {
        debugprint("Downloading remote file: " + remote_file);
        string local_file = local_dir + remote_file.substr(remote_file.find_last_of('/') + 1);
        if (!download_file(sftp, remote_file, local_file))
        {
            cerr << "Failed to download file: " << remote_file << endl;
            return false;
        }
    }
    return true;
}

bool delete_remote_file(sftp_session sftp, const string &remote_file)
{
    return sftp_unlink(sftp, remote_file.c_str()) == SSH_OK;
}

bool delete_local_file(const string &local_file)
{
    return unlink(local_file.c_str()) == 0;
}

bool upload_file(sftp_session sftp, const string &local_file, const string &remote_file)
{
    ifstream file(local_file, ios::binary);
    if (!file)
    {
        cerr << "Error opening local file: " << local_file << endl;
        return false;
    }

    sftp_file sftp_file = sftp_open(sftp, remote_file.c_str(), O_WRONLY | O_CREAT | O_TRUNC, S_IRWXU);
    if (!sftp_file)
    {
        cerr << "Error opening remote file: " << ssh_get_error(sftp) << endl;
        return false;
    }

    char buffer[4096];
    while (file.read(buffer, sizeof(buffer)) || file.gcount() > 0)
    {
        if (sftp_write(sftp_file, buffer, file.gcount()) != file.gcount())
        {
            cerr << "Error writing to remote file: " << ssh_get_error(sftp) << endl;
            sftp_close(sftp_file);
            return false;
        }
    }

    sftp_close(sftp_file);
    return true;
}

int main(int argc, char **argv)
{
    // Check for debug flag
    if (argc > 1 && std::string(argv[1]) == "--debug")
    {
        debug_mode = true;
    }

    debugprint("Starting file transfers.");
    // Get the current time at the start of the binary
    time_t current_time = std::time(NULL);
    char buffer[80];
    strftime(buffer, 80, "%Y-%m-%d %H:%M:%S", localtime(&current_time));

    debugprint("Current time: " + string(buffer));
    // Initialize last_run with the start time of the binary
    time_t last_run = current_time;

    // Create SSH and SFTP sessions for RemoteHost1
    ssh_session ssh_session1 = create_ssh_session(REMOTE_HOST1);
    if (ssh_session1 == NULL)
    {
        std::cerr << "Failed to create SSH session for RemoteHost1" << std::endl;
        return 1;
    }

    sftp_session sftp_session1 = create_sftp_session(ssh_session1);
    if (sftp_session1 == NULL)
    {
        std::cerr << "Failed to create SFTP session for RemoteHost1" << std::endl;
        ssh_disconnect(ssh_session1);
        ssh_free(ssh_session1);
        return 1;
    }

    // Create SSH and SFTP Sessions for RemoteHost2
    ssh_session ssh_session2 = create_ssh_session(REMOTE_HOST2);
    if (ssh_session2 == NULL)
    {
        std::cerr << "Failed to create SSH session for RemoteHost2" << std::endl;
        sftp_free(sftp_session1);
        ssh_disconnect(ssh_session1);
        ssh_free(ssh_session1);
        return 1;
    }

    sftp_session sftp_session2 = create_sftp_session(ssh_session2);
    if (sftp_session2 == NULL)
    {
        std::cerr << "Failed to create SFTP session for RemoteHost1" << std::endl;
        sftp_free(sftp_session1);
        ssh_disconnect(ssh_session1);
        ssh_free(ssh_session1);
        ssh_disconnect(ssh_session2);
        ssh_free(ssh_session2);
        return 1;
    }

    while (true)
    {
        optional<vector<string>> new_files = check_for_new_files(sftp_session1, last_run);
        if (new_files)
        {
            if (download_files(sftp_session1, new_files.value(), LOCAL_PATH))
            {
                // Create a list of local file paths
                std::vector<std::string> local_files;
                for (const auto &remote_file : new_files.value())
                {
                    local_files.push_back(LOCAL_PATH + remote_file.substr(remote_file.find_last_of('/') + 1));
                }

                // Create a zip file locally
                if (create_zip_from_files(local_files, LOCAL_ZIP_PATH, ZIP_PASSPHRASE))
                {

                    if (upload_file(sftp_session2, LOCAL_ZIP_PATH, REMOTE2_DEST_PATH))
                    {
                        debugprint("Transferred archive to RemoteHost2.");

                        // Delete the archive from LocalHost
                        // if (delete_local_file(LOCAL_ZIP_PATH))
                        // {
                        //     debugprint("Deleted local archive file.");
                        // }
                        // else
                        // {
                        //     cerr << "Failed to delete local archive file." << endl;
                        // }
                    }
                    else
                    {
                        cerr << "Failed to upload archive to RemoteHost2." << endl;
                    }
                    // Delete the unzipped files locally
                    for (const auto &local_file : local_files)
                    {
                        if (delete_local_file(local_file))
                        {
                            debugprint("Deleted local file: " + local_file);
                        }
                        else
                        {
                            cerr << "Failed to delete local file: " + local_file << endl;
                        }
                    }
                }
                else
                {
                    cerr << "Failed to create zip file on local host." << endl;
                }
            }
            else
            {
                cerr << "Failed to download file(s) from RemoteHost1." << endl;
            }
        }
        else
        {
            debugprint("No new files found on RemoteHost1.");
        }

        // Update last_run to current time
        last_run = time(NULL);
        this_thread::sleep_for(chrono::seconds(CHECK_INTERVAL));
    }

    // Clean up sessions
    sftp_free(sftp_session2);
    ssh_disconnect(ssh_session2);
    ssh_free(ssh_session2);

    sftp_free(sftp_session1);
    ssh_disconnect(ssh_session1);
    ssh_free(ssh_session1);

    return 0;
}
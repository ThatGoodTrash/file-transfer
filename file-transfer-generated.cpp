#include <iostream>
#include <vector>
#include <string>
#include <chrono>
#include <thread>
#include <semaphore.h>
#include <condition_variable>
#include <libssh/libssh.h>
#include <libssh/sftp.h>
#include <zip.h>
#include <fcntl.h>
#include <fstream>
#include <optional>
#include <unistd.h>
#include <signal.h>

using namespace std;
using namespace std::chrono;

// Constants
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
const size_t MAX_ZIP_SIZE = 5 * 1024 * 1024; // 5 MB

// Global variables for synchronization
sem_t semaphore;
bool stop_requested = false;
vector<string> file_history;

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

// SSH and SFTP sessions
ssh_session create_ssh_session(const string &host);
sftp_session create_sftp_session(ssh_session session);

// File operations
bool list_new_files(sftp_session sftp, const string &path, time_t last_run, vector<string> &new_files);
bool create_zip_from_files(const vector<string> &files, const string &zip_path, const string &password);
optional<vector<string>> check_for_new_files(sftp_session sftp, time_t last_run);
bool download_file(sftp_session sftp, const string &remote_file, vector<char> &file_data);
bool delete_remote_file(sftp_session sftp, const string &remote_file);
bool upload_file(sftp_session sftp, const string &local_file, const string &remote_file);
bool delete_local_file(const string &local_file);
size_t get_file_size(const string &file_path);

void download_routine(sftp_session sftp, time_t &last_run)
{
    while (!stop_requested)
    {
        auto new_files = check_for_new_files(sftp, last_run);
        if (new_files)
        {
            vector<string> local_files;
            vector<char> file_data;
            for (const auto &remote_file : new_files.value())
            {
                debugprint("Downloading remote file: " + remote_file);
                if (download_file(sftp, remote_file, file_data))
                {
                    local_files.push_back(remote_file.substr(remote_file.find_last_of('/') + 1));
                    file_history.push_back(remote_file);
                }
                else
                {
                    cerr << "Failed to download file: " << remote_file << endl;
                }
            }

            // Lock the semaphore to ensure exclusive access while creating/updating the zip file
            sem_wait(&semaphore);
            if (create_zip_from_files(local_files, LOCAL_ZIP_PATH, ZIP_PASSPHRASE))
            {
                debugprint("Created/Updated zip file: " + LOCAL_ZIP_PATH);
            }
            else
            {
                cerr << "Failed to create/update zip file." << endl;
            }
            sem_post(&semaphore);
        }
        last_run = time(NULL);
        this_thread::sleep_for(chrono::seconds(CHECK_INTERVAL));
    }
}

void upload_routine(sftp_session sftp)
{
    while (!stop_requested)
    {
        // Wait for semaphore to ensure the zip file is not being written to
        sem_wait(&semaphore);

        // Check if the local zip file exists and is large enough
        if (get_file_size(LOCAL_ZIP_PATH) > MAX_ZIP_SIZE)
        {
            debugprint("Uploading zip file: " + LOCAL_ZIP_PATH);
            if (upload_file(sftp, LOCAL_ZIP_PATH, REMOTE2_DEST_PATH))
            {
                debugprint("Uploaded zip file to RemoteHost2.");
                if (delete_local_file(LOCAL_ZIP_PATH))
                {
                    debugprint("Deleted local zip file.");
                }
                else
                {
                    cerr << "Failed to delete local zip file." << endl;
                }
            }
            else
            {
                cerr << "Failed to upload zip file to RemoteHost2." << endl;
            }
        }
        sem_post(&semaphore);

        this_thread::sleep_for(chrono::seconds(CHECK_INTERVAL));
    }
}

void signal_handler(int signal)
{
    if (signal == SIGINT)
    {
        cerr << "Signal SIGINT received. Stopping threads..." << endl;
        stop_requested = true;
        sem_post(&semaphore); // Ensure the upload thread exits if it's waiting
    }
}

int main(int argc, char **argv)
{
    // Check for debug flag
    if (argc > 1 && std::string(argv[1]) == "--debug")
    {
        debug_mode = true;
    }

    // Initialize semaphore
    sem_init(&semaphore, 0, 1);

    // Register signal handler
    signal(SIGINT, signal_handler);

    // Create SSH and SFTP sessions for RemoteHost1 and RemoteHost2
    ssh_session ssh_session1 = create_ssh_session(REMOTE_HOST1);
    if (ssh_session1 == NULL)
    {
        cerr << "Failed to create SSH session for RemoteHost1" << endl;
        return 1;
    }
    sftp_session sftp_session1 = create_sftp_session(ssh_session1);
    if (sftp_session1 == NULL)
    {
        cerr << "Failed to create SFTP session for RemoteHost1" << endl;
        ssh_disconnect(ssh_session1);
        ssh_free(ssh_session1);
        return 1;
    }

    ssh_session ssh_session2 = create_ssh_session(REMOTE_HOST2);
    if (ssh_session2 == NULL)
    {
        cerr << "Failed to create SSH session for RemoteHost2" << endl;
        sftp_free(sftp_session1);
        ssh_disconnect(ssh_session1);
        ssh_free(ssh_session1);
        return 1;
    }
    sftp_session sftp_session2 = create_sftp_session(ssh_session2);
    if (sftp_session2 == NULL)
    {
        cerr << "Failed to create SFTP session for RemoteHost2" << endl;
        sftp_free(sftp_session1);
        ssh_disconnect(ssh_session1);
        ssh_free(ssh_session1);
        ssh_disconnect(ssh_session2);
        ssh_free(ssh_session2);
        return 1;
    }

    // Start the download and upload threads
    time_t last_run = time(NULL);
    thread download_thread(download_routine, sftp_session1, ref(last_run));
    thread upload_thread(upload_routine, sftp_session2);

    // Join threads
    download_thread.join();
    upload_thread.join();

    // Clean up semaphore
    sem_destroy(&semaphore);

    // Clean up sessions
    sftp_free(sftp_session2);
    ssh_disconnect(ssh_session2);
    ssh_free(ssh_session2);

    sftp_free(sftp_session1);
    ssh_disconnect(ssh_session1);
    ssh_free(ssh_session1);

    return 0;
}

#include <unistd.h>
#include <iostream>
#include <string.h>
#include <vector>
#include <optional>
#include <libssh/libssh.h>
#include <libssh/sftp.h>
#include <utility>

// Function Prototypes

using namespace std;

// Utilities
void debugprint(const string &message);

bool delete_self();
bool delete_local_file(const string &local_file);
bool delete_remote_file(sftp_session sftp, const string &remote_file);

ssh_session create_ssh_session(const string &host);
sftp_session create_sftp_session(ssh_session session);

bool list_new_files(sftp_session sftp, const string &path, time_t last_run, vector<string> &new_files);
optional<vector<string>> check_for_new_files(sftp_session sftp, time_t last_run);

bool download_file(sftp_session sftp, const string &remote_file, pair<string, string> &file_contents);
bool download_files(sftp_session sftp, const vector<string> &remote_files, pair<string, string> &file_contents);
bool file_exists_in_zip(const string &zip_path, const string &filename);

bool create_zip_from_files(const vector<string> &files, const string &zip_path, const string &password);
bool append_to_zip(const string &file_name, const string &content, const string &zip_path, const string &password);

bool upload_file(sftp_session sftp, const string &local_file, const string &remote_file);

void download_routine(const string &host);
void upload_routine(const string &host, const string &remote_path);

void signal_handler(int signum);
void daemonize();

// Config
const string REMOTE_HOST1 = "127.0.0.1";
const string REMOTE_HOST2 = "127.0.0.1";
const string REMOTE1_COLLECT_DIR = "/tmp/remote1/files/";
const string REMOTE1_ARCHIVE_PATH = "/tmp/remote1/archive.zip";
const string REMOTE2_DEST_PATH = "/tmp/remote2/transferred.zip";
const string PRIVATE_KEY = R"(-----BEGIN OPENSSH PRIVATE KEY-----
-----END OPENSSH PRIVATE KEY-----)";
const string ZIP_PASSPHRASE = "zip_archive_passphrase";
const string LOCAL_PATH = "/tmp/local/";
const string LOCAL_ZIP_PATH = "/tmp/local/local_zip.zip";
const int CHECK_INTERVAL = 5;
// const size_t MAX_ZIP_SIZE = 5 * 1024 * 1024; // 5 MB
const size_t MAX_ZIP_SIZE = 5 * 1024; // 5 KB
const bool DELETE_ON_EXEC = false;

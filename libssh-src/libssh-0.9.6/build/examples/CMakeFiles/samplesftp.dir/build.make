# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.28

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build

# Include any dependencies generated for this target.
include examples/CMakeFiles/samplesftp.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include examples/CMakeFiles/samplesftp.dir/compiler_depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/samplesftp.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/samplesftp.dir/flags.make

examples/CMakeFiles/samplesftp.dir/samplesftp.c.o: examples/CMakeFiles/samplesftp.dir/flags.make
examples/CMakeFiles/samplesftp.dir/samplesftp.c.o: /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/samplesftp.c
examples/CMakeFiles/samplesftp.dir/samplesftp.c.o: examples/CMakeFiles/samplesftp.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object examples/CMakeFiles/samplesftp.dir/samplesftp.c.o"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT examples/CMakeFiles/samplesftp.dir/samplesftp.c.o -MF CMakeFiles/samplesftp.dir/samplesftp.c.o.d -o CMakeFiles/samplesftp.dir/samplesftp.c.o -c /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/samplesftp.c

examples/CMakeFiles/samplesftp.dir/samplesftp.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/samplesftp.dir/samplesftp.c.i"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/samplesftp.c > CMakeFiles/samplesftp.dir/samplesftp.c.i

examples/CMakeFiles/samplesftp.dir/samplesftp.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/samplesftp.dir/samplesftp.c.s"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/samplesftp.c -o CMakeFiles/samplesftp.dir/samplesftp.c.s

examples/CMakeFiles/samplesftp.dir/authentication.c.o: examples/CMakeFiles/samplesftp.dir/flags.make
examples/CMakeFiles/samplesftp.dir/authentication.c.o: /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/authentication.c
examples/CMakeFiles/samplesftp.dir/authentication.c.o: examples/CMakeFiles/samplesftp.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object examples/CMakeFiles/samplesftp.dir/authentication.c.o"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT examples/CMakeFiles/samplesftp.dir/authentication.c.o -MF CMakeFiles/samplesftp.dir/authentication.c.o.d -o CMakeFiles/samplesftp.dir/authentication.c.o -c /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/authentication.c

examples/CMakeFiles/samplesftp.dir/authentication.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/samplesftp.dir/authentication.c.i"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/authentication.c > CMakeFiles/samplesftp.dir/authentication.c.i

examples/CMakeFiles/samplesftp.dir/authentication.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/samplesftp.dir/authentication.c.s"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/authentication.c -o CMakeFiles/samplesftp.dir/authentication.c.s

examples/CMakeFiles/samplesftp.dir/knownhosts.c.o: examples/CMakeFiles/samplesftp.dir/flags.make
examples/CMakeFiles/samplesftp.dir/knownhosts.c.o: /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/knownhosts.c
examples/CMakeFiles/samplesftp.dir/knownhosts.c.o: examples/CMakeFiles/samplesftp.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object examples/CMakeFiles/samplesftp.dir/knownhosts.c.o"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT examples/CMakeFiles/samplesftp.dir/knownhosts.c.o -MF CMakeFiles/samplesftp.dir/knownhosts.c.o.d -o CMakeFiles/samplesftp.dir/knownhosts.c.o -c /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/knownhosts.c

examples/CMakeFiles/samplesftp.dir/knownhosts.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/samplesftp.dir/knownhosts.c.i"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/knownhosts.c > CMakeFiles/samplesftp.dir/knownhosts.c.i

examples/CMakeFiles/samplesftp.dir/knownhosts.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/samplesftp.dir/knownhosts.c.s"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/knownhosts.c -o CMakeFiles/samplesftp.dir/knownhosts.c.s

examples/CMakeFiles/samplesftp.dir/connect_ssh.c.o: examples/CMakeFiles/samplesftp.dir/flags.make
examples/CMakeFiles/samplesftp.dir/connect_ssh.c.o: /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/connect_ssh.c
examples/CMakeFiles/samplesftp.dir/connect_ssh.c.o: examples/CMakeFiles/samplesftp.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object examples/CMakeFiles/samplesftp.dir/connect_ssh.c.o"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT examples/CMakeFiles/samplesftp.dir/connect_ssh.c.o -MF CMakeFiles/samplesftp.dir/connect_ssh.c.o.d -o CMakeFiles/samplesftp.dir/connect_ssh.c.o -c /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/connect_ssh.c

examples/CMakeFiles/samplesftp.dir/connect_ssh.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/samplesftp.dir/connect_ssh.c.i"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/connect_ssh.c > CMakeFiles/samplesftp.dir/connect_ssh.c.i

examples/CMakeFiles/samplesftp.dir/connect_ssh.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/samplesftp.dir/connect_ssh.c.s"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/connect_ssh.c -o CMakeFiles/samplesftp.dir/connect_ssh.c.s

# Object files for target samplesftp
samplesftp_OBJECTS = \
"CMakeFiles/samplesftp.dir/samplesftp.c.o" \
"CMakeFiles/samplesftp.dir/authentication.c.o" \
"CMakeFiles/samplesftp.dir/knownhosts.c.o" \
"CMakeFiles/samplesftp.dir/connect_ssh.c.o"

# External object files for target samplesftp
samplesftp_EXTERNAL_OBJECTS =

examples/samplesftp: examples/CMakeFiles/samplesftp.dir/samplesftp.c.o
examples/samplesftp: examples/CMakeFiles/samplesftp.dir/authentication.c.o
examples/samplesftp: examples/CMakeFiles/samplesftp.dir/knownhosts.c.o
examples/samplesftp: examples/CMakeFiles/samplesftp.dir/connect_ssh.c.o
examples/samplesftp: examples/CMakeFiles/samplesftp.dir/build.make
examples/samplesftp: src/libssh.a
examples/samplesftp: /usr/lib/x86_64-linux-gnu/libcrypto.so
examples/samplesftp: /usr/lib/x86_64-linux-gnu/libz.so
examples/samplesftp: /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so
examples/samplesftp: /usr/lib/x86_64-linux-gnu/libkrb5.so
examples/samplesftp: /usr/lib/x86_64-linux-gnu/libk5crypto.so
examples/samplesftp: /usr/lib/x86_64-linux-gnu/libcom_err.so
examples/samplesftp: examples/CMakeFiles/samplesftp.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking C executable samplesftp"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/samplesftp.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/samplesftp.dir/build: examples/samplesftp
.PHONY : examples/CMakeFiles/samplesftp.dir/build

examples/CMakeFiles/samplesftp.dir/clean:
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && $(CMAKE_COMMAND) -P CMakeFiles/samplesftp.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/samplesftp.dir/clean

examples/CMakeFiles/samplesftp.dir/depend:
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6 /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples/CMakeFiles/samplesftp.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : examples/CMakeFiles/samplesftp.dir/depend


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
include examples/CMakeFiles/proxy.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include examples/CMakeFiles/proxy.dir/compiler_depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/proxy.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/proxy.dir/flags.make

examples/CMakeFiles/proxy.dir/proxy.c.o: examples/CMakeFiles/proxy.dir/flags.make
examples/CMakeFiles/proxy.dir/proxy.c.o: /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/proxy.c
examples/CMakeFiles/proxy.dir/proxy.c.o: examples/CMakeFiles/proxy.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object examples/CMakeFiles/proxy.dir/proxy.c.o"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT examples/CMakeFiles/proxy.dir/proxy.c.o -MF CMakeFiles/proxy.dir/proxy.c.o.d -o CMakeFiles/proxy.dir/proxy.c.o -c /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/proxy.c

examples/CMakeFiles/proxy.dir/proxy.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/proxy.dir/proxy.c.i"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/proxy.c > CMakeFiles/proxy.dir/proxy.c.i

examples/CMakeFiles/proxy.dir/proxy.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/proxy.dir/proxy.c.s"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples/proxy.c -o CMakeFiles/proxy.dir/proxy.c.s

# Object files for target proxy
proxy_OBJECTS = \
"CMakeFiles/proxy.dir/proxy.c.o"

# External object files for target proxy
proxy_EXTERNAL_OBJECTS =

examples/proxy: examples/CMakeFiles/proxy.dir/proxy.c.o
examples/proxy: examples/CMakeFiles/proxy.dir/build.make
examples/proxy: src/libssh.a
examples/proxy: /usr/lib/x86_64-linux-gnu/libcrypto.so
examples/proxy: /usr/lib/x86_64-linux-gnu/libz.so
examples/proxy: /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so
examples/proxy: /usr/lib/x86_64-linux-gnu/libkrb5.so
examples/proxy: /usr/lib/x86_64-linux-gnu/libk5crypto.so
examples/proxy: /usr/lib/x86_64-linux-gnu/libcom_err.so
examples/proxy: examples/CMakeFiles/proxy.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable proxy"
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/proxy.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/proxy.dir/build: examples/proxy
.PHONY : examples/CMakeFiles/proxy.dir/build

examples/CMakeFiles/proxy.dir/clean:
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples && $(CMAKE_COMMAND) -P CMakeFiles/proxy.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/proxy.dir/clean

examples/CMakeFiles/proxy.dir/depend:
	cd /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6 /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/examples /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples /home/kali/projects/file-transfer/libssh-src/libssh-0.9.6/build/examples/CMakeFiles/proxy.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : examples/CMakeFiles/proxy.dir/depend


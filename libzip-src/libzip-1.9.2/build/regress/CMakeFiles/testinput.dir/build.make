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
CMAKE_SOURCE_DIR = /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build

# Utility rule file for testinput.

# Include any custom commands dependencies for this target.
include regress/CMakeFiles/testinput.dir/compiler_depend.make

# Include the progress variables for this target.
include regress/CMakeFiles/testinput.dir/progress.make

regress/CMakeFiles/testinput: /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/regress/manyfiles-zip.zip
regress/CMakeFiles/testinput: /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/regress/bigzero-zip.zip
	cd /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/regress && /usr/bin/cmake -E tar x /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/regress/manyfiles-zip.zip
	cd /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/regress && /usr/bin/cmake -E tar x /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/regress/bigzero-zip.zip

testinput: regress/CMakeFiles/testinput
testinput: regress/CMakeFiles/testinput.dir/build.make
.PHONY : testinput

# Rule to build all files generated by this target.
regress/CMakeFiles/testinput.dir/build: testinput
.PHONY : regress/CMakeFiles/testinput.dir/build

regress/CMakeFiles/testinput.dir/clean:
	cd /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/regress && $(CMAKE_COMMAND) -P CMakeFiles/testinput.dir/cmake_clean.cmake
.PHONY : regress/CMakeFiles/testinput.dir/clean

regress/CMakeFiles/testinput.dir/depend:
	cd /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2 /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/regress /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/regress /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/regress/CMakeFiles/testinput.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : regress/CMakeFiles/testinput.dir/depend

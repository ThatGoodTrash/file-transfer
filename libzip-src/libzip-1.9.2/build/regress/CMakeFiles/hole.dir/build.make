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

# Include any dependencies generated for this target.
include regress/CMakeFiles/hole.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include regress/CMakeFiles/hole.dir/compiler_depend.make

# Include the progress variables for this target.
include regress/CMakeFiles/hole.dir/progress.make

# Include the compile flags for this target's objects.
include regress/CMakeFiles/hole.dir/flags.make

regress/CMakeFiles/hole.dir/hole.c.o: regress/CMakeFiles/hole.dir/flags.make
regress/CMakeFiles/hole.dir/hole.c.o: /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/regress/hole.c
regress/CMakeFiles/hole.dir/hole.c.o: regress/CMakeFiles/hole.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object regress/CMakeFiles/hole.dir/hole.c.o"
	cd /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/regress && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT regress/CMakeFiles/hole.dir/hole.c.o -MF CMakeFiles/hole.dir/hole.c.o.d -o CMakeFiles/hole.dir/hole.c.o -c /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/regress/hole.c

regress/CMakeFiles/hole.dir/hole.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/hole.dir/hole.c.i"
	cd /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/regress && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/regress/hole.c > CMakeFiles/hole.dir/hole.c.i

regress/CMakeFiles/hole.dir/hole.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/hole.dir/hole.c.s"
	cd /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/regress && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/regress/hole.c -o CMakeFiles/hole.dir/hole.c.s

regress/CMakeFiles/hole.dir/source_hole.c.o: regress/CMakeFiles/hole.dir/flags.make
regress/CMakeFiles/hole.dir/source_hole.c.o: /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/regress/source_hole.c
regress/CMakeFiles/hole.dir/source_hole.c.o: regress/CMakeFiles/hole.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object regress/CMakeFiles/hole.dir/source_hole.c.o"
	cd /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/regress && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT regress/CMakeFiles/hole.dir/source_hole.c.o -MF CMakeFiles/hole.dir/source_hole.c.o.d -o CMakeFiles/hole.dir/source_hole.c.o -c /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/regress/source_hole.c

regress/CMakeFiles/hole.dir/source_hole.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/hole.dir/source_hole.c.i"
	cd /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/regress && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/regress/source_hole.c > CMakeFiles/hole.dir/source_hole.c.i

regress/CMakeFiles/hole.dir/source_hole.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/hole.dir/source_hole.c.s"
	cd /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/regress && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/regress/source_hole.c -o CMakeFiles/hole.dir/source_hole.c.s

# Object files for target hole
hole_OBJECTS = \
"CMakeFiles/hole.dir/hole.c.o" \
"CMakeFiles/hole.dir/source_hole.c.o"

# External object files for target hole
hole_EXTERNAL_OBJECTS =

regress/hole: regress/CMakeFiles/hole.dir/hole.c.o
regress/hole: regress/CMakeFiles/hole.dir/source_hole.c.o
regress/hole: regress/CMakeFiles/hole.dir/build.make
regress/hole: lib/libzip.a
regress/hole: /usr/lib/x86_64-linux-gnu/libcrypto.so
regress/hole: /usr/lib/x86_64-linux-gnu/libz.so
regress/hole: regress/CMakeFiles/hole.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable hole"
	cd /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/regress && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/hole.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
regress/CMakeFiles/hole.dir/build: regress/hole
.PHONY : regress/CMakeFiles/hole.dir/build

regress/CMakeFiles/hole.dir/clean:
	cd /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/regress && $(CMAKE_COMMAND) -P CMakeFiles/hole.dir/cmake_clean.cmake
.PHONY : regress/CMakeFiles/hole.dir/clean

regress/CMakeFiles/hole.dir/depend:
	cd /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2 /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/regress /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/regress /home/kali/projects/file-transfer/libzip-src/libzip-1.9.2/build/regress/CMakeFiles/hole.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : regress/CMakeFiles/hole.dir/depend


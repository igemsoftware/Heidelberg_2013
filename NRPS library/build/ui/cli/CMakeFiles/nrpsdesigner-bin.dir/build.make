# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
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
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = "/home/nils/NRPSDesigner/NRPS library"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "/home/nils/NRPSDesigner/NRPS library/build"

# Include any dependencies generated for this target.
include ui/cli/CMakeFiles/nrpsdesigner-bin.dir/depend.make

# Include the progress variables for this target.
include ui/cli/CMakeFiles/nrpsdesigner-bin.dir/progress.make

# Include the compile flags for this target's objects.
include ui/cli/CMakeFiles/nrpsdesigner-bin.dir/flags.make

ui/cli/CMakeFiles/nrpsdesigner-bin.dir/main.cpp.o: ui/cli/CMakeFiles/nrpsdesigner-bin.dir/flags.make
ui/cli/CMakeFiles/nrpsdesigner-bin.dir/main.cpp.o: ../ui/cli/main.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report "/home/nils/NRPSDesigner/NRPS library/build/CMakeFiles" $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object ui/cli/CMakeFiles/nrpsdesigner-bin.dir/main.cpp.o"
	cd "/home/nils/NRPSDesigner/NRPS library/build/ui/cli" && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/nrpsdesigner-bin.dir/main.cpp.o -c "/home/nils/NRPSDesigner/NRPS library/ui/cli/main.cpp"

ui/cli/CMakeFiles/nrpsdesigner-bin.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/nrpsdesigner-bin.dir/main.cpp.i"
	cd "/home/nils/NRPSDesigner/NRPS library/build/ui/cli" && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E "/home/nils/NRPSDesigner/NRPS library/ui/cli/main.cpp" > CMakeFiles/nrpsdesigner-bin.dir/main.cpp.i

ui/cli/CMakeFiles/nrpsdesigner-bin.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/nrpsdesigner-bin.dir/main.cpp.s"
	cd "/home/nils/NRPSDesigner/NRPS library/build/ui/cli" && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S "/home/nils/NRPSDesigner/NRPS library/ui/cli/main.cpp" -o CMakeFiles/nrpsdesigner-bin.dir/main.cpp.s

ui/cli/CMakeFiles/nrpsdesigner-bin.dir/main.cpp.o.requires:
.PHONY : ui/cli/CMakeFiles/nrpsdesigner-bin.dir/main.cpp.o.requires

ui/cli/CMakeFiles/nrpsdesigner-bin.dir/main.cpp.o.provides: ui/cli/CMakeFiles/nrpsdesigner-bin.dir/main.cpp.o.requires
	$(MAKE) -f ui/cli/CMakeFiles/nrpsdesigner-bin.dir/build.make ui/cli/CMakeFiles/nrpsdesigner-bin.dir/main.cpp.o.provides.build
.PHONY : ui/cli/CMakeFiles/nrpsdesigner-bin.dir/main.cpp.o.provides

ui/cli/CMakeFiles/nrpsdesigner-bin.dir/main.cpp.o.provides.build: ui/cli/CMakeFiles/nrpsdesigner-bin.dir/main.cpp.o

# Object files for target nrpsdesigner-bin
nrpsdesigner__bin_OBJECTS = \
"CMakeFiles/nrpsdesigner-bin.dir/main.cpp.o"

# External object files for target nrpsdesigner-bin
nrpsdesigner__bin_EXTERNAL_OBJECTS =

ui/cli/nrpsdesigner: ui/cli/CMakeFiles/nrpsdesigner-bin.dir/main.cpp.o
ui/cli/nrpsdesigner: ui/cli/CMakeFiles/nrpsdesigner-bin.dir/build.make
ui/cli/nrpsdesigner: lib/nrpsdesigner/libnrpsdesigner.a
ui/cli/nrpsdesigner: /usr/lib/x86_64-linux-gnu/libcurl.so
ui/cli/nrpsdesigner: /usr/lib/libmysqlcppconn.so
ui/cli/nrpsdesigner: /usr/lib/libboost_program_options.so
ui/cli/nrpsdesigner: /usr/lib/x86_64-linux-gnu/libxml2.so
ui/cli/nrpsdesigner: /usr/lib/x86_64-linux-gnu/libmysqlclient.so
ui/cli/nrpsdesigner: /usr/lib/libmysqlcppconn.so
ui/cli/nrpsdesigner: /usr/lib/libboost_program_options.so
ui/cli/nrpsdesigner: ui/cli/CMakeFiles/nrpsdesigner-bin.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable nrpsdesigner"
	cd "/home/nils/NRPSDesigner/NRPS library/build/ui/cli" && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/nrpsdesigner-bin.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
ui/cli/CMakeFiles/nrpsdesigner-bin.dir/build: ui/cli/nrpsdesigner
.PHONY : ui/cli/CMakeFiles/nrpsdesigner-bin.dir/build

ui/cli/CMakeFiles/nrpsdesigner-bin.dir/requires: ui/cli/CMakeFiles/nrpsdesigner-bin.dir/main.cpp.o.requires
.PHONY : ui/cli/CMakeFiles/nrpsdesigner-bin.dir/requires

ui/cli/CMakeFiles/nrpsdesigner-bin.dir/clean:
	cd "/home/nils/NRPSDesigner/NRPS library/build/ui/cli" && $(CMAKE_COMMAND) -P CMakeFiles/nrpsdesigner-bin.dir/cmake_clean.cmake
.PHONY : ui/cli/CMakeFiles/nrpsdesigner-bin.dir/clean

ui/cli/CMakeFiles/nrpsdesigner-bin.dir/depend:
	cd "/home/nils/NRPSDesigner/NRPS library/build" && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" "/home/nils/NRPSDesigner/NRPS library" "/home/nils/NRPSDesigner/NRPS library/ui/cli" "/home/nils/NRPSDesigner/NRPS library/build" "/home/nils/NRPSDesigner/NRPS library/build/ui/cli" "/home/nils/NRPSDesigner/NRPS library/build/ui/cli/CMakeFiles/nrpsdesigner-bin.dir/DependInfo.cmake" --color=$(COLOR)
.PHONY : ui/cli/CMakeFiles/nrpsdesigner-bin.dir/depend


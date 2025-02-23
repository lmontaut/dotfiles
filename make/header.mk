# Lou automated compilation/build system
# Do not change the name of the variables, as they are used by the make commands.
# You can however give them any value you want.
# Note: $() evaluates a Make variable
#       $$  evaluates the shell -> add an extra '$' to escape Make

# You would typically put the following content inside a Makefile, which would then
# call the config.mk file from these dotfiles:

# ------------------------------------------
# COMPILATION TARGET
# ------------------------------------------
TARGET ?= all

# ------------------------------------------
# COMPILATION MODE
# ------------------------------------------
# MODE   ?= Release
MODE   ?= RelWithDebInfo
# MODE   ?= Debug

COMPILE_ALL_TESTS ?= OFF
ifeq ($(COMPILE_ALL_TESTS),OFF)
MODE_NAME := $(MODE)NoTests
else ifeq ($(COMPILE_ALL_TESTS),ON)
MODE_NAME := $(MODE)
else
$(error COMPILE_ALL_TESTS must be ON or OFF)
endif

# ------------------------------------------
# NUMBER OF CPUS FOR COMPILATION
# ------------------------------------------
JLEVEL ?= 8

# ------------------------------------------
# TEST TARGETS
# ------------------------------------------
# -- which targets to compile if not all are compiled
TEST_TARGET ?= name-of-test-target

# -- which regex to use for ctest --run_test=regex
TEST_LAUNCH_REGEX ?= some-regex

# -- for individual tests (when a test executable has multiple tests)
TEST_NAME_PREFIX ?= prefix-common-to-all-tests
TEST_NAME ?= name-of-test

# ------------------------------------------
# COMPILATION FLAGS
# ------------------------------------------
ADDITIONAL_COMPILATION_FLAGS ?= -Wall\
																-Wextra
																# -Wno-\#warnings\
																# -Wno-deprecated-declarations

# Note: the double "" "" on cxx flags is important here, as
# the command line argument is -DCMAKE_CXX_FLAGS="flag1 flag2 ..."
# So to convert the flags list into something that remains inside "",
# we need these double "" ""
PROJECT_SPECIFIC_BUILD_FLAGS ?= -DBUILD_TESTING=$(COMPILE_ALL_TESTS)

FLAGS ?=

LOU_CMAKE_FLAGS ?= -G Ninja\
									 -DCMAKE_BUILD_TYPE=$(MODE)\
									 -DCMAKE_INSTALL_PREFIX=$(CONDA_PREFIX)\
									 -DCMAKE_SYSTEM_PREFIX_PATH=$(CONDA_PREFIX)\
									 -DCMAKE_CXX_FLAGS_DEBUG="-g -O0"\
									 -DCMAKE_CXX_FLAGS_RELWITHDEBINFO="-g -O2"\
									 -DCMAKE_C_FLAGS_DEBUG="-g -O0"\
									 -DCMAKE_C_FLAGS_RELWITHDEBINFO="-g -O2"\
									 -DCMAKE_EXPORT_COMPILE_COMMANDS=ON\
									 -DCMAKE_CXX_COMPILER_LAUNCHER=ccache\
									 -DCMAKE_C_COMPILER_LAUNCHER=ccache

# Set build dir - here using conda
LOU_BUILD_DIR := ./build/$(CONDA_DEFAULT_ENV)/$(MODE_NAME)
TEST_DIR := unittest
MODE_DIR := .lou/$(CONDA_DEFAULT_ENV)

include $(HOME)/dotfiles/make/config.mk

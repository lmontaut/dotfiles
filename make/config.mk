# ------------------------------------------------
# COMMON TO ALL PROJECTS
# Note: $() evaluates a Make variable
#       $$  evaluates the shell -> add an extra '$' to escape Make
define _FUTILS
	store_current_mode() {
		printf "%s %s %s\n" "$$1" "$$2" "$$3" > $(MODE_FILE)
		# echo "--> Stored build mode: $$1 $$2 $$3"
	}

	echo_current_mode() {
		if [ -f $(MODE_FILE) ]; then
			read -r MODE_ MODE_NAME_ COMP_FLAGS_ < $(MODE_FILE);
			echo "Current build configuration:"
			echo "  --> MODE: $$MODE_"
			echo "  --> MODE_NAME: $$MODE_NAME_"
			echo "  --> PROJECT_SPECIFIC_BUILD_FLAGS: $$COMP_FLAGS_"
		fi
	}

	uninstall_previous_mode() {
		if [ -f $(MODE_FILE) ]; then
			read -r PREV_MODE PREV_MODE_NAME PREV_COMP_FLAGS_ < $(MODE_FILE);
			if [ "$$PREV_MODE_NAME" != "$(MODE_NAME)" ]; then
				if [ -d ./build/$(CONDA_DEFAULT_ENV)/$$PREV_MODE_NAME ]; then
					# echo "--> Build mode changed from $$PREV_MODE_NAME to $(MODE_NAME), uninstalling $$PREV_MODE_NAME";
					make uninstall MODE="$$PREV_MODE" MODE_NAME="$$PREV_MODE_NAME" PROJECT_SPECIFIC_BUILD_FLAGS="$$PREV_COMP_FLAGS_"
				fi
			fi
		fi
	}

	uninstall_current_mode() {
		if [ -f $(MODE_FILE) ]; then
			read -r MODE_ MODE_NAME_ COMP_FLAGS_ < $(MODE_FILE);
			if [ -d ./build/$(CONDA_DEFAULT_ENV)/$$MODE_NAME_ ]; then
				# echo "--> Uninstalling current mode $$MODE_NAME_";
				make uninstall MODE="$$MODE_" MODE_NAME="$$MODE_NAME_" PROJECT_SPECIFIC_BUILD_FLAGS="$$COMP_FLAGS_"
			fi
		fi
	}

	auto_update_mode() {
		if [ -f $(MODE_FILE) ]; then
			read -r MODE_ MODE_NAME_ COMP_FLAGS_ < $(MODE_FILE);
			if [ "$$COMP_FLAGS_" != "$(PROJECT_SPECIFIC_BUILD_FLAGS)" ]; then
				make update
			fi
		fi
	}

endef
export _FUTILS

.PHONY: all test tests compile install

all:
	make _lou_preambule
	cmake --build $(LOU_BUILD_DIR) --target all $(FLAGS) -j$(JLEVEL)
	@printf "[Compilation finished.]\n\n"

# -----------
# Installing
# -----------
install:
	make _lou_preambule
	cmake --build $(LOU_BUILD_DIR) --target install -j$(JLEVEL) $(FLAGS)

uninstall:
	cmake --build $(LOU_BUILD_DIR) --target uninstall -j$(JLEVEL) $(FLAGS)

# ------
# Testing
# ------
# We always clear the previous and current mode, to make sure we use the correct files
tests: all
	ctest --output-on-failure -j$(JLEVEL) --test-dir $(LOU_BUILD_DIR) $(FLAGS)

retests:
	ctest --rerun-failed --output-on-failure -j$(JLEVEL) --test-dir $(LOU_BUILD_DIR) $(FLAGS)

test:
	@if [ -z "$(TEST_TARGET)" ]; then echo "Failed. Please do: make test TEST_TARGET=<name-of-test>"; exit 1; fi
	make compile TARGET="$(TEST_TARGET)"
	ctest --test-dir $(LOU_BUILD_DIR) --output-on-failure -R "$(TEST_LAUNCH_REGEX)" $(FLAGS)

subtest:
	@if [ -z "$(TEST_TARGET)" ]; then echo "Failed. Please do: make test TEST_TARGET=<name-of-test> TEST_NAME=<name-of-unit-test>"; exit 1; fi
	@if [ -z "$(TEST_NAME)" ]; then echo "Failed. Please do: make test TEST=<name-of-test> TEST_NAME=<name-of-unit-test>"; exit 1; fi
	make compile TARGET=$(TEST_TARGET)
	./$(LOU_BUILD_DIR)/$(TEST_DIR)/$(TEST_TARGET) --run_test=$(TEST_NAME_PREFIX)$(TEST_NAME) $(FLAGS)

# ---------
# Compiling
# ---------
compile:
	make _lou_preambule
	cmake --build $(LOU_BUILD_DIR) --target $(TARGET) -j$(JLEVEL) $(FLAGS)

compile_:
	make _lou_preambule
	cmake --build $(LOU_BUILD_DIR) -j$(JLEVEL) $(FLAGS)

# --------
# Building
# --------
BUILD_COMMAND_ = cmake -S . -B $(LOU_BUILD_DIR) $(LOU_CMAKE_FLAGS) $(PROJECT_SPECIFIC_BUILD_FLAGS) $(FLAGS) # Add additionnal flags if needed

# we don't store the current mode, because no compilation command is launched
update:
	rm -rf $(LOU_BUILD_DIR)/CMakeCache.txt
	$(BUILD_COMMAND_)

# same as update but destroys the existing build folder.
build: mkdir_build
	$(BUILD_COMMAND_)

clean:
	cmake --build $(LOU_BUILD_DIR) --target clean

mkdir_build: clean_build
	mkdir -p $(LOU_BUILD_DIR)

clean_build:
	rm -rf $(LOU_BUILD_DIR)

link_compile_commands:
	ln -sf $(LOU_BUILD_DIR)/compile_commands.json ./

echo_mode:
	@eval "$$_FUTILS"; echo_current_mode;

_store_current_mode:
	@eval "$$_FUTILS"; store_current_mode "$(MODE)" "$(MODE_NAME)" "$(PROJECT_SPECIFIC_BUILD_FLAGS)";

_uninstall_previous_mode:
	@eval "$$_FUTILS"; uninstall_previous_mode;

_uninstall_current_mode:
	@eval "$$_FUTILS"; uninstall_current_mode;

_auto_update_mode:
	@eval "$$_FUTILS"; auto_update_mode;

_lou_preambule:
	make _uninstall_previous_mode
	make _uninstall_current_mode
	make _auto_update_mode
	make _store_current_mode

# --------
# Misc
# --------

precom:
	pre-commit run --files $$(git ls-files -m)

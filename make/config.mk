# ------------------------------------------------
# COMMON TO ALL PROJECTS
define _FUTILS
	store_current_mode() {
		printf "%s %s\n" "$$1" "$$2" > $(MODE_FILE)
		echo "Stored build mode: $$1 $$2"
	}

	echo_current_mode() {
		if [ -f $(MODE_FILE) ]; then
			read -r MODE_ MODE_NAME_ < $(MODE_FILE);
			echo "Current build configuration:"
			echo "  --> MODE: $$MODE_"
			echo "  --> MODE_NAME: $$MODE_NAME_"
		fi
	}

	clear_previous_mode() {
		if [ -f $(MODE_FILE) ]; then
			read -r PREV_MODE PREV_MODE_NAME < $(MODE_FILE);
			if [ "$$PREV_MODE_NAME" != "$(MODE_NAME)" ]; then
				if [ -d ./build/$(CONDA_DEFAULT_ENV)/$$PREV_MODE_NAME ]; then
					echo "Build mode changed from $$PREV_MODE_NAME to $(MODE_NAME)";
					make uninstall MODE=$$PREV_MODE MODE_NAME=$$PREV_MODE_NAME
				fi
			fi
		fi
	}
endef
export _FUTILS

.PHONY: all test tests compile install

all:
	@eval "$$_FUTILS"; clear_previous_mode;
	cmake --build $(LOU_BUILD_DIR) --target all $(FLAGS) -j$(JLEVEL)
	@eval "$$_FUTILS"; store_current_mode "$(MODE)" "$(MODE_NAME)";
	@printf "[Compilation finished.]\n\n"

# -----------
# Installing
# -----------
install:
	@eval "$$_FUTILS"; clear_previous_mode;
	cmake --build $(LOU_BUILD_DIR) --target install -j$(JLEVEL) $(FLAGS)
	@eval "$$_FUTILS"; store_current_mode "$(MODE)" "$(MODE_NAME)";

uninstall:
	cmake --build $(LOU_BUILD_DIR) --target uninstall -j$(JLEVEL) $(FLAGS)

# ------
# Testing
# ------
# We always clear the previous and current mode, to make sure we use the correct files
tests: all
	@eval "$$_FUTILS"; clear_previous_mode;
	ctest --output-on-failure -j$(JLEVEL) --test-dir $(LOU_BUILD_DIR) $(FLAGS)
	@eval "$$_FUTILS"; store_current_mode "$(MODE)" "$(MODE_NAME)";

retests:
	@eval "$$_FUTILS"; clear_previous_mode;
	ctest --rerun-failed --output-on-failure -j$(JLEVEL) --test-dir $(LOU_BUILD_DIR) $(FLAGS)
	@eval "$$_FUTILS"; store_current_mode "$(MODE)" "$(MODE_NAME)";

test:
	@eval "$$_FUTILS"; clear_previous_mode;
	@if [ -z "$(TEST_TARGET)" ]; then echo "Failed. Please do: make test TEST_TARGET=<name-of-test>"; exit 1; fi
	make compile TARGET="$(TEST_TARGET)"
	ctest --test-dir $(LOU_BUILD_DIR) --output-on-failure -R "$(TEST_LAUNCH_REGEX)" $(FLAGS)
	@eval "$$_FUTILS"; store_current_mode "$(MODE)" "$(MODE_NAME)";

subtest:
	@eval "$$_FUTILS"; clear_previous_mode;
	@if [ -z "$(TEST_TARGET)" ]; then echo "Failed. Please do: make test TEST_TARGET=<name-of-test> TEST_NAME=<name-of-unit-test>"; exit 1; fi
	@if [ -z "$(TEST_NAME)" ]; then echo "Failed. Please do: make test TEST=<name-of-test> TEST_NAME=<name-of-unit-test>"; exit 1; fi
	make compile TARGET=$(TEST_TARGET)
	./$(LOU_BUILD_DIR)/$(TEST_DIR)/$(TEST_TARGET) --run_test=$(TEST_NAME_PREFIX)$(TEST_NAME) $(FLAGS)
	@eval "$$_FUTILS"; store_current_mode "$(MODE)" "$(MODE_NAME)";

# ---------
# Compiling
# ---------
compile:
	@eval "$$_FUTILS"; clear_previous_mode;
	cmake --build $(LOU_BUILD_DIR) --target $(TARGET) -j$(JLEVEL) $(FLAGS)
	@eval "$$_FUTILS"; store_current_mode "$(MODE)" "$(MODE_NAME)";

compile_:
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

# for debugging only
_store_current_mode:
	@eval "$$_FUTILS"; store_current_mode "$(MODE)" "$(MODE_NAME)";

_clear_previous_mode:
	@eval "$$_FUTILS"; clear_previous_mode;

#!/bin/bash

echo
echo "----------------- RANGER INSTALL -----------------"
RANGER_DIR="$HOME/workspace/misc/ranger"
if [ -d "$RANGER_DIR" ]; then
    echo "--> Found ranger at: $RANGER_DIR/ranger.py"
fi

# Prompt for confirmation
while true; do
    read -p "--> Install ranger? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> ranger won't get installed"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

# Delete if already exists
rm -rf "$RANGER_DIR"
echo "  --> Installing ranger..."
git clone --recursive https://github.com/ranger/ranger.git $RANGER_DIR

# Create ranger command
CURRENT_SHELL=$(basename "$SHELL")
if [ "$CURRENT_SHELL" = "zsh" ]; then
  SHELL_CONFIG_FILE="$HOME/.zshrc"
elif [ "$CURRENT_SHELL" = "bash" ]; then
  SHELL_CONFIG_FILE="$HOME/.bashrc"
else
  echo "  --> $CURRENT_SHELL is not supported"
  [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

# Get the actual file path if .zshrc is a symlink
SHELLRC_PATH=$(readlink $SHELL_CONFIG_FILE || echo $SHELL_CONFIG_FILE)

# Update .zshrc to use the new theme
SHELLRC_CONTENT=$(cat "$SHELLRC_PATH")
if ! echo "$SHELLRC_CONTENT" | grep -q '^alias ranger=.*$/d'; then
    # Create a temporary file
    TEMP_FILE=$(mktemp)

    # Delete already existing command and add command at the end of file
    echo "$SHELLRC_CONTENT" | sed '/^alias ranger=.*$/d' > "$TEMP_FILE"
    COMMAND="alias ranger=\"python $RANGER_DIR/ranger.py\""
    echo "$COMMAND" >> "$TEMP_FILE"

    # Backup original file
    cp "$SHELLRC_PATH" "$SHELLRC_PATH.bak"

    # Move temp file to the actual target file
    mv "$TEMP_FILE" "$SHELLRC_PATH"
fi

echo "  --> Installed ranger"


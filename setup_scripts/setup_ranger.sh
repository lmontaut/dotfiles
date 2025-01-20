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

COMMAND="alias ranger=\"python $RANGER_DIR/ranger.py\""
echo "$COMMAND" >> "$SHELL_CONFIG_FILE"

echo "  --> Installed ranger"


#!/bin/bash

# This script installs zsh and changes the default shell to zsh.
# This script requires root privileges.

echo
echo "----------------- ZSH INSTALL -----------------"

if command -v zsh &> /dev/null; then
    echo "--> Found zsh at: $(which zsh)"
    current_version=$(zsh --version)
    echo "--> zsh version: ($current_version)"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
fi

# Prompt for confirmation
while true; do
    read -p "--> Install zsh (requires root privileges)? (y/n) " -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> zsh won't get installed."
        # handle exits from shell or function but don't exit interactive shell
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

if [[ "$(uname)" == "Darwin" ]]; then
    echo "  --> You're on MacOs, zsh should be default. That's weird. Aborting."
    exit 1
elif [[ "$(uname)" == "Linux" ]]; then
    sudo apt-get install zsh
else
    echo "Unsupported operating system"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
echo "  --> zsh installed at $(which zsh)"

# Print version to confirm installation
echo "  --> Version: $(zsh --version)"

while true; do
    read -p "  --> Make zsh the default shell? If so, the rest of the install will happen in zsh, otherwise  it will happen in $SHELL. (y/n) " -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> zsh not set to default."
        # handle exits from shell or function but don't exit interactive shell
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

# Make zsh the default shell
chsh -s (which zsh)

echo "--> Please exit your shell, relaunch it, check that zsh is the default shell. Then, re-execute this setup script."
exit 0

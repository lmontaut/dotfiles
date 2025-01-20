#!/bin/bash

echo
echo "----------------- TMUX INSTALL -----------------"

# Detect if already exists, we won't reinstall if already there as tmux is system-wide
if command -v tmux &> /dev/null; then
    echo "--> Found tmux at: $(which tmux)"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
fi

# Prompt for confirmation
while true; do
    read -p "--> Could not find tmux. Install it (requires root privileges)? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> tmux won't get installed"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

# Detect OS and architecture
if [[ "$(uname)" == "Darwin" ]]; then
    echo "  --> Installing tmux..."
    brew install tmux
elif [[ "$(uname)" == "Linux" ]]; then
    echo "  --> Installing tmux..."
    sudo apt-get install -y tmux
else
    echo "  --> Unsupported operating system"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

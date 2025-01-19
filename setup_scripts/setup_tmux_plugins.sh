#!/bin/bash

# Prompt for confirmation
while true; do
    read -p "--> Install tmux plugins? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> tmux plugins won't get installed"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

echo "  --> Installing tmux plugins..."
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

echo "  --> tmux plugins installed"
echo "      Launch a new tmux server, then prefix + I (C-a + I) for automatic install"

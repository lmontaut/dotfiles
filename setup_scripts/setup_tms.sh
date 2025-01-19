#!/bin/bash

echo
echo "----------------- TMUX SESSIONIZER INSTALL -----------------"

if command -v tms &> /dev/null; then
    echo "--> Found tms at: $(which tms)"
    current_version=$(tms --version)
    echo "--> tms version: ($current_version)"
fi

# Prompt for confirmation
while true; do
    read -p "--> Install tms? (y/n) " -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> tms won't get installed"
        # handle exits from shell or function but don't exit interactive shell
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

echo "  --> Installing tms using cargo..."
cargo install tmux-sessionizer 
tms config --paths $HOME/workspace $HOME/dotfiles
echo "  --> tms installation complete, ran: tms config --paths \$HOME/workspace \$HOME/dotfiles"
echo "  --> Modify the tms paths: tms config --paths list-of-paths"

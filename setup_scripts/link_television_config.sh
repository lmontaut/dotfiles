#!/bin/bash

echo
while true; do
    read -p "--> Link the dofiles' television config files? (y/n) " -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> No linking"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

# Linking config file to home
link_config $DOTFILES_DIR/television/.config/television $HOME/.config/television

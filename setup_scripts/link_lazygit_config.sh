#!/bin/bash

echo
while true; do
    read -p "--> Link the dofiles' lazygit config files? (y/n) " -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> No linking"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

# Linking config file to home
rm -rf $HOME/.config/lazygit # delete existing
ln -sf $DOTFILES_DIR/lazygit/.config/lazygit $HOME/.config

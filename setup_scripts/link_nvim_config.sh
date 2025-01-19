#!/bin/bash

while true; do
    read -p "--> Link the dofiles nvim config files? (y/n) " -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

echo "  --> Linking config files $DOTFILES_DIR/nvim/.config/nvim to $HOME/.config"
ln -sf $DOTFILES_DIR/nvim/.config/nvim $HOME/.config

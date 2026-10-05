#!/bin/bash

echo
while true; do
    read -p "--> Link the dofiles' nvim config files? (y/n) " -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> No linking"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done


if [ ! -e "$DOTFILES_DIR/nvim/.config/nvim/init.lua" ] && [ ! -e "$DOTFILES_DIR/nvim/.config/nvim/init.vim" ]; then
    echo "  --> Warning: the nvim submodule looks empty, run: git submodule update --init --recursive"
fi
link_config $DOTFILES_DIR/nvim/.config/nvim $HOME/.config/nvim

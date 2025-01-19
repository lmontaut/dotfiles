#!/bin/bash

while true; do
    read -p "--> Link the dofiles alacritty config files? (y/n) " -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

# Linking config file to home
if [[ "$(uname)" == "Darwin" ]]; then
    echo "  --> Linking config files $DOTFILES_DIR/macos/zsh/* to $HOME"
    ln -sf $DOTFILES_DIR/macos/zsh/* $HOME
elif [[ "$(uname)" == "Linux" ]]; then
    echo "  --> Linking config files $DOTFILES_DIR/linux/zsh/* to $HOME"
    ln -sf $DOTFILES_DIR/linux/zsh/* $HOME
else
    echo "Unsupported operating system"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

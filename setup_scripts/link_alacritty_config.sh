#!/bin/bash

echo
while true; do
    read -p "--> Link the dofiles' alacritty config files? (y/n) " -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> No linking"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

# Linking config file to home
if [[ "$(uname)" == "Darwin" ]]; then
    link_config $DOTFILES_DIR/macos/alacritty/.config/alacritty $HOME/.config/alacritty
elif [[ "$(uname)" == "Linux" ]]; then
    link_config $DOTFILES_DIR/linux/alacritty/.config/alacritty $HOME/.config/alacritty
else
    echo "Unsupported operating system"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

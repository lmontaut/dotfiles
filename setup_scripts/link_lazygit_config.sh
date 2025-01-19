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
if [[ "$(uname)" == "Darwin" ]]; then
    echo "  --> Linking config files $DOTFILES_DIR/macos/lazygit/.config/lazygit to $HOME/.config"
    ln -sf $DOTFILES_DIR/macos/lazygit/.config/lazygit $HOME/.config
elif [[ "$(uname)" == "Linux" ]]; then
    echo "  --> Linking config files $DOTFILES_DIR/linux/lazygit/.config/lazygit to $HOME/.config"
    ln -sf $DOTFILES_DIR/linux/lazygit/.config/lazygit $HOME/.config
else
    echo "Unsupported operating system"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

#!/bin/bash

echo
while true; do
    read -p "--> Link the dofiles' zsh config files? (y/n) " -n 1 -r
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
    link_config $DOTFILES_DIR/macos/zsh/.zshrc $HOME/.zshrc
    link_config $DOTFILES_DIR/macos/zsh/.zshrc_config $HOME/.zshrc_config
elif [[ "$(uname)" == "Linux" ]]; then
    link_config $DOTFILES_DIR/linux/zsh/.zshrc $HOME/.zshrc
    link_config $DOTFILES_DIR/linux/zsh/.zshrc_config $HOME/.zshrc_config
else
    echo "Unsupported operating system"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

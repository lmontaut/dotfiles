#!/bin/bash

echo
echo "----------------- GITCONFIG -----------------"
while true; do
    echo "--> These dotfiles' config setup basic git options (user, signing commits, diffs etc.)"
    read -p "--> Link the dofiles' git config? (y/n) " -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> No linking"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

# Linking config file to home
echo "  --> Linking $DOTFILES_DIR/git/.gitconfig to $HOME"
ln -sf $DOTFILES_DIR/git/.gitconfig $HOME 
echo "  --> To activate the gitconfig:"
echo "      1) Modify 'signingkey' in $HOME/.gitconfig to put your ssh signing key"
echo "      2) Modify $HOME/.config/git/allowed_signers with your public ssh signing key"

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
link_config $DOTFILES_DIR/git/.gitconfig $HOME/.gitconfig
if [ "$DOTFILES_DIR" != "$HOME/dotfiles" ]; then
    echo "  --> Warning: .gitconfig expects this repo at ~/dotfiles (core.excludesfile)"
fi

# Commits are signed (commit.gpgsign): the key path is per machine, in the
# untracked ~/.gitconfig_local included at the end of .gitconfig. Over ssh,
# signing works with the key in the forwarded agent: only the .pub is needed.
if [ ! -e "$HOME/.gitconfig_local" ]; then
    printf '[user]\n\tsigningkey = %s\n' "$HOME/.ssh/ed25519.pub" > "$HOME/.gitconfig_local"
    echo "  --> Created $HOME/.gitconfig_local (signingkey = $HOME/.ssh/ed25519.pub)"
fi
if [ ! -f "$HOME/.ssh/ed25519.pub" ]; then
    echo "  --> Warning: $HOME/.ssh/ed25519.pub is missing: commits can't be signed."
    echo "      Copy your public signing key there (or edit $HOME/.gitconfig_local)"
fi
echo "  --> Put your public ssh signing key in $HOME/.config/git/allowed_signers to verify signatures"

#!/bin/bash

# This script installs zsh (apt with root, else pixi global) and makes it the
# default shell: chsh when possible, else bash exec's zsh from ~/.bashrc (no
# root, LDAP accounts or a zsh outside /etc/shells, e.g. on a cluster).

if command -v zsh &> /dev/null; then
    echo "--> Found zsh at: $(which zsh)"
    echo "--> zsh version: ($(zsh --version))"
else
    while true; do
        read -p "--> Install zsh? (y/n) " -n 1 -r
        echo    # Move to a new line
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            break
        elif [[ $REPLY =~ ^[Nn]$ ]]; then
            echo "  --> zsh won't get installed."
            # handle exits from shell or function but don't exit interactive shell
            [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
        fi
    done

    if [[ "$(uname)" == "Darwin" ]]; then
        echo "  --> You're on MacOs, zsh should be default. That's weird. Aborting."
        exit 1
    elif [[ "$(uname)" == "Linux" ]]; then
        linux_install zsh
    else
        echo "Unsupported operating system"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
    fi
    if ! command -v zsh &> /dev/null; then
        echo "  --> zsh installation FAILED"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
    fi
    echo "  --> zsh installed at $(which zsh)"
    echo "  --> Version: $(zsh --version)"
fi

[ "$(basename "$SHELL")" = zsh ] && { [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0; }

while true; do
    read -p "  --> Make zsh the default shell (currently $SHELL)? (y/n) " -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> zsh not set to default."
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

ZSH_BIN=$(command -v zsh)
if grep -qxF "$ZSH_BIN" /etc/shells 2>/dev/null && chsh -s "$ZSH_BIN"; then
    echo "  --> Default shell set to $ZSH_BIN (log out/in for it to take effect)"
else
    # Interactive bash only: scp/rsync/ssh <cmd> keep running in bash
    append_once "[[ \$- == *i* ]] && [ -x \"$ZSH_BIN\" ] && exec \"$ZSH_BIN\" -l" "$HOME/.bashrc"
    echo "  --> chsh not possible: ~/.bashrc now exec's $ZSH_BIN in interactive shells"
    echo "      (make sure ~/.bash_profile sources ~/.bashrc for ssh logins)"
fi

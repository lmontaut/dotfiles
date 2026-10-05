#!/bin/bash

echo
while true; do
    read -p "--> Link the dofiles' ccache config? (y/n) " -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> No linking"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

# ccache reads $XDG_CONFIG_HOME/ccache when XDG_CONFIG_HOME is set (our zsh
# config sets it), else ~/Library/Preferences/ccache on macOS: link both.
link_config $DOTFILES_DIR/ccache/.config/ccache/ccache.conf $HOME/.config/ccache/ccache.conf
if [[ "$(uname)" == "Darwin" ]]; then
    link_config $DOTFILES_DIR/ccache/.config/ccache/ccache.conf "$HOME/Library/Preferences/ccache/ccache.conf"
fi

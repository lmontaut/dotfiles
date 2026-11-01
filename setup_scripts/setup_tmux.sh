#!/bin/bash

echo
echo "----------------- TMUX INSTALL -----------------"

# The tmux config needs tmux >= 3.3 (display-popup, terminal-features,
# allow-passthrough). Clusters often ship an older one: install a recent tmux
# in ~/.pixi/bin, which comes first in PATH.
TMUX_MIN_VERSION=3.3
if command -v tmux &> /dev/null; then
    tmux_version=$(tmux -V | sed 's/[^0-9.]//g')
    echo "--> Found tmux $tmux_version at: $(which tmux)"
    if [ "$(printf '%s\n' $TMUX_MIN_VERSION "$tmux_version" | sort -V | head -n1)" = "$TMUX_MIN_VERSION" ]; then
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
    prompt="--> tmux $tmux_version is too old for this config (needs >= $TMUX_MIN_VERSION). Install a recent one?"
else
    prompt="--> Could not find tmux. Install it?"
fi

# Prompt for confirmation
while true; do
    read -p "$prompt (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> tmux won't get installed"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

# Detect OS and architecture
if [[ "$(uname)" == "Darwin" ]]; then
    echo "  --> Installing tmux..."
    brew install tmux
elif [[ "$(uname)" == "Linux" ]]; then
    echo "  --> Installing tmux..."
    # apt's tmux can be too old too (Ubuntu 20.04: 3.0): pixi when one is already there
    if command -v tmux &> /dev/null; then
        pixi_install tmux
    else
        linux_install tmux
    fi
    hash -r
    echo "  --> tmux: $(command -v tmux) ($(tmux -V))"
else
    echo "  --> Unsupported operating system"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

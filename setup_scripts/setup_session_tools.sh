#!/bin/bash

# Session/navigation tools used by the tmux + television workflow:
#   zoxide (z/zi), jq, television (tv), sesh (tmux sessions), worktrunk (wt)
# macOS: brew. Linux: apt when available, else latest GitHub release in ~/.local/bin.

echo
echo "----------------- SESSION TOOLS (zoxide, jq, tv, sesh, worktrunk) -----------------"

ARCH=$(uname -m)                       # x86_64 | aarch64 | arm64
[[ "$ARCH" == "arm64" ]] && ARCH=aarch64
SESH_ARCH=$ARCH
[[ "$SESH_ARCH" == "aarch64" ]] && SESH_ARCH=arm64

install_zoxide() {
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install zoxide
    else
        install_github_binary ajeetdsouza/zoxide "${ARCH}-unknown-linux-musl\.tar\.gz$" zoxide
    fi
}

install_jq() {
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install jq
    elif command -v apt-get &> /dev/null; then
        sudo apt-get install -y jq
    fi
}

install_tv() {
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install television
    else
        install_github_binary alexpasmantier/television "${ARCH}-unknown-linux-gnu\.tar\.gz$" tv
    fi
}

install_sesh() {
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install sesh
    else
        install_github_binary joshmedeski/sesh "sesh_Linux_${SESH_ARCH}\.tar\.gz$" sesh
    fi
}

install_worktrunk() {
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install worktrunk
    else
        install_github_binary max-sixty/worktrunk "worktrunk-${ARCH}-unknown-linux-musl\.tar\.xz$" wt
    fi
}

ask_install zoxide zoxide install_zoxide
ask_install "jq (needed by the tv worktrunk channel)" jq install_jq
ask_install "television (tv)" tv install_tv
ask_install sesh sesh install_sesh
ask_install "worktrunk (wt)" wt install_worktrunk

# tmux popups (display-popup) need tmux >= 3.2
if command -v tmux &> /dev/null; then
    tmux_version=$(tmux -V | sed 's/[^0-9.]//g')
    if [ "$(printf '%s\n' 3.2 "$tmux_version" | sort -V | head -n1)" != "3.2" ]; then
        echo
        echo "--> Warning: tmux $tmux_version is too old for the tv popups (needs >= 3.2)"
    fi
fi

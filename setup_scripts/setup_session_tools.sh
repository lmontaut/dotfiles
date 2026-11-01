#!/bin/bash

# Session/navigation tools used by the tmux + television workflow:
#   zoxide (z/zi), jq, television (tv), sesh (tmux sessions), worktrunk (wt)
# macOS: brew. Linux: apt with root, else latest GitHub release in ~/.local/bin.

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
    elif can_apt; then
        sudo apt-get install -y jq
    else
        # static binary, no archive
        local arch=amd64
        [[ "$ARCH" == "aarch64" ]] && arch=arm64
        mkdir -p "$HOME/.local/bin"
        wget -qO "$HOME/.local/bin/jq" "https://github.com/jqlang/jq/releases/latest/download/jq-linux-$arch" &&
            chmod +x "$HOME/.local/bin/jq"
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

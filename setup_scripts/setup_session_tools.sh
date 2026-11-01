#!/bin/bash

# Session/navigation tools used by the tmux + television workflow:
#   zoxide (z/zi), jq, television (tv), sesh (tmux sessions), worktrunk (wt),
#   gh (GitHub CLI, used by octo.nvim)
# macOS: brew. Linux: apt with root, else latest GitHub release in ~/.local/bin.

echo
echo "----------------- SESSION TOOLS (zoxide, jq, tv, sesh, worktrunk, gh) -----------------"

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
        # musl build is static (the gnu one needs a recent glibc, too new for
        # clusters); only published for x86_64
        local libc=musl
        [ "$ARCH" = "x86_64" ] || libc=gnu
        install_github_binary alexpasmantier/television "${ARCH}-unknown-linux-${libc}\.tar\.gz$" tv
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

install_gh() {
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install gh
    else
        # static Go binary
        local arch=amd64
        [[ "$ARCH" == "aarch64" ]] && arch=arm64
        install_github_binary cli/cli "gh_[0-9.]+_linux_${arch}\.tar\.gz$" gh
    fi
}

ask_install zoxide zoxide install_zoxide
ask_install "jq (needed by the tv worktrunk channel)" jq install_jq
ask_install "television (tv)" tv install_tv
ask_install sesh sesh install_sesh
ask_install "worktrunk (wt)" wt install_worktrunk
ask_install "gh (GitHub CLI, for octo.nvim; then run gh auth login)" gh install_gh

#!/bin/bash

detect_os () {
    if [[ "$(uname)" == "Darwin" ]]; then
        if [[ "$(uname -m)" == "arm64" ]]; then
            echo "--> Detected OS: Darwin arm64"
        else
            echo "--> Detected OS: Darwin x86"
        fi
    elif [[ "$(uname)" == "Linux" ]]; then
        echo "--> Detected OS: Linux $(uname -m)"
    else
        echo "Unsupported operating system"
        exit 1
    fi
}

setup_base_folders () {
    mkdir -p $HOME/.config
    mkdir -p $HOME/.local
    mkdir -p $HOME/.local/bin
    mkdir -p $HOME/.local/include
    mkdir -p $HOME/.local/lib
    mkdir -p $HOME/.local/share
    mkdir -p $HOME/.local/share/applications
    mkdir -p $HOME/.local/state
}

create_workspace () {
    echo
    while true; do
        read -p "--> Setup lou's standard workspace directories? (y/n) " -n 1 -r
        echo    # Move to a new line
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mkdir -p $HOME/workspace
            mkdir -p $HOME/workspace/robotics
            mkdir -p $HOME/workspace/maths
            mkdir -p $HOME/workspace/graphics
            mkdir -p $HOME/workspace/simulation
            mkdir -p $HOME/workspace/misc
            break
        elif [[ $REPLY =~ ^[Nn]$ ]]; then
            echo "  --> No workspace setup"
            break
        fi
    done
}

# link_config <source> <destination>
# Symlink <destination> -> <source>. An existing file/dir that isn't already a
# symlink is moved aside to <destination>.bak instead of being deleted.
link_config () {
    local src=$1 dest=$2
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "  --> Moving existing $dest to $dest.bak"
        rm -rf "$dest.bak"
        mv "$dest" "$dest.bak"
    fi
    mkdir -p "$(dirname "$dest")"
    # -n: replace an existing symlink to a directory instead of linking inside it
    ln -sfn "$src" "$dest"
    echo "  --> Linked $dest -> $src"
}

# append_once <line> <file>: append <line> to <file> unless already present.
# Use $SHELL_LOCAL_FILE (set in setup.sh) for machine-specific shell config, so
# the tracked ~/.zshrc (a symlink into this repo) is never modified.
append_once () {
    local line=$1 file=$2
    touch "$file"
    grep -qxF -- "$line" "$file" || echo "$line" >> "$file"
}

# github_latest_asset <owner/repo> <regex>: print the download URL of the
# latest release asset whose name matches <regex>.
github_latest_asset () {
    wget -qO- "https://api.github.com/repos/$1/releases/latest" |
        grep "browser_download_url" | cut -d '"' -f 4 | grep -E "$2" | head -n1
}

# install_github_binary <owner/repo> <asset regex> <binary name>
# Download the latest release archive and copy <binary name> to ~/.local/bin.
install_github_binary () {
    local repo=$1 pattern=$2 bin=$3 url tmp
    url=$(github_latest_asset "$repo" "$pattern")
    if [ -z "$url" ]; then
        echo "  --> Could not find a release asset of $repo matching '$pattern'"
        return 1
    fi
    tmp=$(mktemp -d)
    echo "  --> Downloading $url"
    wget -qO "$tmp/archive" "$url" && tar xf "$tmp/archive" -C "$tmp" || { rm -rf "$tmp"; return 1; }
    mkdir -p "$HOME/.local/bin"
    find "$tmp" -type f -name "$bin" -exec install -m 755 {} "$HOME/.local/bin/$bin" \; -quit
    rm -rf "$tmp"
    command -v "$bin" &> /dev/null
}

# ask_install <label> <binary> <install function>
# Ask whether to (re)install a tool, run <install function>, report the result.
ask_install() {
    local label=$1 bin=$2 fn=$3
    echo
    if command -v "$bin" &> /dev/null; then
        echo "--> Found $label at: $(command -v "$bin")"
    fi
    while true; do
        read -p "--> Install $label? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "  --> Installing $label..."
            if $fn && command -v "$bin" &> /dev/null; then
                echo "  --> $label installed at: $(command -v "$bin")"
            else
                echo "  --> $label installation FAILED"
            fi
            break
        elif [[ $REPLY =~ ^[Nn]$ ]]; then
            echo "  --> $label won't get installed"
            break
        fi
    done
}

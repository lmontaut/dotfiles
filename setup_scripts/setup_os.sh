#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
    if ! command -v brew > /dev/null 2>&1; then
        while true; do
            read -p "--> Could not find brew, install it? You need it for this installer to work (y/n) " -n 1 -r
            echo    # Move to a new line
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                # brew isn't on PATH yet in this shell
                for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
                    [ -x "$b" ] && eval "$($b shellenv)" && break
                done
                break
            elif [[ $REPLY =~ ^[Nn]$ ]]; then
                echo "  --> brew won't get installed. Aborting."
                exit 1
            fi
        done
    fi
    brew update
    echo "  --> Installing minimum packages from brew: wget, unzip"
    brew install wget unzip
elif [[ "$(uname)" == "Linux" ]]; then
    # Without sudo (e.g. a cluster), whatever needs root goes through
    # `pixi global` instead (see linux_install in utils.sh)
    while true; do
        read -p "--> Do you have root privileges (sudo) on this machine? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            export HAS_SUDO=y
            break
        elif [[ $REPLY =~ ^[Nn]$ ]]; then
            export HAS_SUDO=n
            echo "  --> No root: system packages will be installed with pixi global (~/.pixi/bin)"
            break
        fi
    done

    if can_apt; then
        echo "  --> Installing minimum packages from apt: git, wget, unzip, curl, xz-utils"
        sudo apt-get update
        sudo apt-get install -y git wget unzip curl xz-utils
    else
        missing=()
        for tool in git wget unzip curl xz; do
            command -v $tool &> /dev/null || missing+=($tool)
        done
        if [ ${#missing[@]} -gt 0 ]; then
            echo "  --> Installing missing minimum packages with pixi: ${missing[*]}"
            pixi_install "${missing[@]}"
        fi
    fi
else
    echo "Unsupported operating system"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

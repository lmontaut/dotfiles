#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
    if ! command -v brew > /dev/null 2>&1; then
        while true; do
            read -p "--> Could not find brew, install it? You need it for this installer to work (y/n) " -n 1 -r
            echo    # Move to a new line
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                break
            elif [[ $REPLY =~ ^[Nn]$ ]]; then
                echo "  --> brew won't get installed. Aborting."
                exit 1
            fi
        done
    fi
    brew install wget
elif [[ "$(uname)" == "Linux" ]]; then
    if ! command -v apt > /dev/null 2>&1; then
        echo "--> Could not find apt package manager. This installer needs it."
        exit 1
    fi
    if ! command -v git > /dev/null 2>&1; then
        while true; do
            read -p "--> Could not find git, install it? You need it for this installer to work (y/n) " -n 1 -r
            echo    # Move to a new line
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sudo apt-get install git
                break
            elif [[ $REPLY =~ ^[Nn]$ ]]; then
                echo "  --> git won't get installed. Aborting."
                exit 1
            fi
        done
    fi
    if ! command -v wget > /dev/null 2>&1; then
        while true; do
            read -p "--> Could not find wget, install it? You need it for this installer to work (y/n) " -n 1 -r
            echo    # Move to a new line
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sudo apt-get install wget
                break
            elif [[ $REPLY =~ ^[Nn]$ ]]; then
                echo "  --> wget won't get installed. Aborting."
                exit 1
            fi
        done
    fi
else
    echo "Unsupported operating system"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

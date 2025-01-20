#!/bin/bash

detect_os () {
    if [[ "$(uname)" == "Darwin" ]]; then
        if [[ "$(uname -m)" == "arm64" ]]; then
            echo "--> Detected OS: Darwin arm64"
        else
            echo "--> Detected OS: Darwin x86"
        fi
    elif [[ "$(uname)" == "Linux" ]]; then
        echo "--> Detected OS: Linux x86"
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
    mkdir -p $HOME/.local/state
    mkdir -p $HOME/.local/applications
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

#!/bin/bash

echo
echo "----------------- CONDA INSTALL -----------------"

if [ -n "$CONDA_EXE" ]; then # $CONDA_EXE is not empty
    echo "--> Found conda at: $(which $CONDA_EXE)"
    current_version=$($CONDA_EXE --version)
    echo "--> conda version: ($current_version)"
    eval "$(conda shell.bash hook)"
    if [[ "$CONDA_DEFAULT_ENV" != "base" ]]; then
        conda activate base # make sure we are in base env
    fi
fi

while true; do
    read -p "--> Install conda? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> conda won't get installed"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

# Delete if existing
rm -rf $CONDA_PREFIX

echo "  --> Installing conda..."
if [[ "$(uname)" == "Darwin" ]]; then
    if [[ "$(uname -m)" == "arm64" ]]; then
        DOWNLOAD_LINK="https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh"
    else
        DOWNLOAD_LINK="https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh"
    fi
elif [[ "$(uname)" == "Linux" ]]; then
    DOWNLOAD_LINK="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
else
    echo "Unsupported operating system"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

# Create a temporary directory
TMP_DIR=$(mktemp -d)
cd $TMP_DIR

wget -O conda.sh "$DOWNLOAD_LINK"
bash conda.sh

# Cleanup
cd - > /dev/null
rm -rf "$TMP_DIR"

#!/bin/bash

echo
echo "----------------- NVIM CUSTOM PLUGINS -----------------"

add_nvim_pap () {
    mkdir -p $HOME/workspace
    mkdir -p $HOME/workspace/misc
    mkdir -p $HOME/workspace/misc/nvim
    rm -rf $HOME/workspace/misc/nvim/nvim-pap
    git clone git@github.com:lmontaut/nvim-pap.git $HOME/workspace/misc/nvim/nvim-pap
}

while true; do
    read -p "--> Install nvim-pap? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        add_nvim_pap
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> nvim-pap won't get installed"
        break
    fi
done

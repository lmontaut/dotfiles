#!/bin/bash

echo
echo "----------------- CARGO INSTALL -----------------"

while true; do
    read -p "--> Install cargo? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> cargo won't get installed"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

echo "  --> Installing cargo..."
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
echo "  --> rustc: $(which rustc)"
echo "  --> rustc version: $(rustc --version)"
echo "  --> cargo: $(which cargo)"
echo "  --> cargo version: $(cargo --version)"

# Cargo
echo '. "$HOME/.cargo/env"' >> $SHELL_CONFIG_FILE

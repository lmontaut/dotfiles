#!/bin/bash

echo
echo "----------------- CARGO INSTALL -----------------"

if command -v rustc &> /dev/null; then
    echo "--> Found rustc at: $(which rustc)"
    current_rustc_version=$(rustc --version)
    echo "--> rustc version: ($current_rustc_version)"
fi

if command -v cargo &> /dev/null; then
    echo "--> Found cargo at: $(which cargo)"
    current_cargo_version=$(cargo --version)
    echo "--> cargo version: ($current_cargo_version)"
fi

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
wget -qO- https://sh.rustup.rs | sh
source $HOME/.cargo/env
echo "  --> Cargo installation complete"
echo "  --> rustc: $(which rustc)"
echo "  --> rustc version: $(rustc --version)"
echo "  --> cargo: $(which cargo)"
echo "  --> cargo version: $(cargo --version)"

# Cargo
echo '. "$HOME/.cargo/env"' >> $SHELL_CONFIG_FILE

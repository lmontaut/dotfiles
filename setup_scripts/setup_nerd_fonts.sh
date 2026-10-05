#!/bin/bash

echo
echo "----------------- NERD FONTS INSTALL -----------------"

# Prompt for confirmation
while true; do
    read -p "--> Install JetBrainsMono nerd fonts? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> nerd fonts won't get installed"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

if [[ "$(uname)" == "Darwin" ]]; then
    FONTS_DIR="$HOME/Library/Fonts"
else
    FONTS_DIR="$HOME/.local/share/fonts"
fi
mkdir -p "$FONTS_DIR"

TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"
DOWNLOAD_SUFFIX="JetBrainsMono.zip"

LATEST_URL=$(wget -qO- https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | \
         grep "browser_download_url.*${DOWNLOAD_SUFFIX}\"" | \
         cut -d '"' -f 4)

# Download and extract
echo "  --> Downloading JetBrainsMono from $LATEST_URL..."
wget "$LATEST_URL"


echo "  --> Installing JetBrainsMono to $FONTS_DIR/JetBrainsMono..."
unzip -o -q JetBrainsMono.zip -d "$FONTS_DIR/JetBrainsMono"
command -v fc-cache &> /dev/null && fc-cache -f

# Cleanup
cd - > /dev/null
rm -rf "$TMP_DIR"

echo "  --> JetBrainsMono nerd font installation complete"

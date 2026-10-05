#!/bin/bash

echo
echo "----------------- ALACRITTY INSTALL -----------------"

if command -v alacritty &> /dev/null; then
    echo "--> Found alacritty at: $(which alacritty)"
    current_version=$(alacritty --version)
    echo "--> alacritty version: ($current_version)"
fi

while true; do
    read -p "--> Install alacritty? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> alacritty won't get installed"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

if [[ "$(uname)" == "Linux" ]]; then
    echo "  --> Installing alacritty dependencies"
    sudo apt-get install -y cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
fi

echo "  --> Installing alacritty using cargo..."
cargo install alacritty
echo "  --> Adding desktop shortcut to alacritty..."
# Linking config file to home
ALACRITTY_PATH=$(which alacritty)
if [[ "$(uname)" == "Darwin" ]]; then
    mkdir -p $HOME/Applications
    mkdir -p $HOME/Applications/Alacritty.app
    mkdir -p $HOME/Applications/Alacritty.app/Contents
    mkdir -p $HOME/Applications/Alacritty.app/Contents/MacOS
    ln -sf $ALACRITTY_PATH $HOME/Applications/Alacritty.app/Contents/MacOS
    ADK_PATH="$HOME/Applications/Alacritty.app/Contents/Info.plist"
    cat > $ADK_PATH <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>CFBundleExecutable</key>
<string>alacritty</string>
<key>CFBundleIdentifier</key>
<string>org.alacritty</string>
<key>CFBundleName</key>
<string>Alacritty</string>
<key>CFBundlePackageType</key>
<string>APPL</string>
<key>CFBundleShortVersionString</key>
<string>1.0</string>
</dict>
</plist>
PLIST
elif [[ "$(uname)" == "Linux" ]]; then
    mkdir -p $HOME/.local/share/applications
    ADK_PATH="$HOME/.local/share/applications/alacritty.desktop"
    echo "[Desktop Entry]" > $ADK_PATH # no >> to overide existing
    echo "Type=Application" >> $ADK_PATH
    echo "Name=Alacritty" >> $ADK_PATH
    echo "Comment=A fast, cross-platform, OpenGL terminal emulator" >> $ADK_PATH
    echo "Icon=terminal" >> $ADK_PATH
    echo "Exec=$ALACRITTY_PATH" >> $ADK_PATH
    echo "Categories=System;TerminalEmulator;" >> $ADK_PATH
    echo "Terminal=false" >> $ADK_PATH # don't launch in a terminal, alacritty is a terminal itself
    chmod +x $ADK_PATH
else
    echo "Unsupported operating system"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

echo "  --> Alacritty installation complete"

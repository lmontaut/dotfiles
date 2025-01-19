#!/bin/bash

echo
echo "----------------- ALACRITTY INSTALL -----------------"

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

# Linking config file to home
echo "  --> Installing alacritty using cargo..."
cargo install alacritty
echo "  --> Adding desktop shortcut to alacritty..."
ALACRITTY_PATH=$(which alacritty)
if [[ "$(uname)" == "Darwin" ]]; then
    mkdir -p $HOME/Applications
    mkdir -p $HOME/Applications/Alacritty.app
    mkdir -p $HOME/Applications/Alacritty.app/Contents
    mkdir -p $HOME/Applications/Alacritty.app/Contents/MacOS
    ln -sf $ALACRITTY_PATH $HOME/Applications/Alacritty.app/Contents/MacOS
    ADK_PATH="$HOME/Applications/Alacritty.app/Contents/Info.plist"
    touch $ADK_PATH
    echo "<?xml version="1.0" encoding="UTF-8"?>" > $ADK_PATH # no >> to overide existing
    echo "<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">" >> $ADK_PATH
    echo "<plist version="1.0">" >> $ADK_PATH
    echo "<dict>" >> $ADK_PATH
    echo "<key>CFBundleExecutable</key>" >> $ADK_PATH
    echo "<string>alacritty</string>" >> $ADK_PATH
    echo "<key>CFBundleIdentifier</key>" >> $ADK_PATH
    echo "<string>com.example.myapp</string>" >> $ADK_PATH
    echo "<key>CFBundleName</key>" >> $ADK_PATH
    echo "<string>Alacritty</string>" >> $ADK_PATH
    echo "<key>CFBundlePackageType</key>" >> $ADK_PATH
    echo "<string>APPL</string>" >> $ADK_PATH
    echo "<key>CFBundleShortVersionString</key>" >> $ADK_PATH
    echo "<string>1.0</string>" >> $ADK_PATH
    echo "</dict>" >> $ADK_PATH
    echo "</plist>" >> $ADK_PATH
elif [[ "$(uname)" == "Linux" ]]; then
    ADK_PATH="$HOME/.local/share/applications/alacritty.desktop"
    touch $ADK_PATH
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

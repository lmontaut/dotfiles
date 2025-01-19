#!/bin/bash

echo
echo "----------------- LAZYGIT INSTALL -----------------"

if command -v lazygit &> /dev/null; then
    echo "--> Found lazygit at: $(which lazygit)"
    current_version=$(lazygit --version)
    echo "--> lazygit version: ($current_version)"
fi

# Prompt for confirmation
while true; do
    read -p "--> Install lazygit? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> lazygit won't get installed"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

# Detect OS and architecture
if [[ "$(uname)" == "Darwin" ]]; then
    brew install jesseduffield/lazygit/lazygit
elif [[ "$(uname)" == "Linux" ]]; then
    # Create ~/.local/bin if it doesn't exist
    mkdir -p $HOME/.local/bin

    TMP_DIR=$(mktemp -d)
    cd "$TMP_DIR"

    DOWNLOAD_SUFFIX="Linux_x86_64.tar.gz"

    LATEST_URL=$(wget -qO- https://api.github.com/repos/jesseduffield/lazygit/releases/latest | \
             grep "browser_download_url.*lazygit_.*${DOWNLOAD_SUFFIX}\"" | \
             cut -d '"' -f 4)

    # Download and extract
    echo "  --> Downloading lazygit from $LATEST_URL..."
    wget -O lazygit.tar.gz "$LATEST_URL"
    tar xf lazygit.tar.gz lazygit

    # Move the binary to ~/.local/bin
    echo "  --> Installing lazygit to $HOME/.local/bin..."
    install -D lazygit "${HOME}/.local/bin/lazygit"

    # Cleanup
    cd $DOTFILES_DIR
    rm -rf "$TMP_DIR"

    # Make sure ~/.local/bin is in PATH
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo "  --> Warning: ~/.local/bin is not in your PATH"
        echo "      Add this line to your shell configuration file (~/.bashrc, ~/.zshrc, etc.):"
        echo '      export PATH="$HOME/.local/bin:$PATH"'
        while true; do
            read -p "  --> Should I do it for you? (y/n) " -n 1 -r
            echo    # Move to a new line
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                echo 'export PATH="$HOME/.local/bin:$PATH"' >> $HOME/.zshrc
                break
            elif [[ $REPLY =~ ^[Nn]$ ]]; then
                break
            fi
        done
    fi
else
    echo "  --> Unsupported operating system"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

# Print version to confirm installation
echo "  --> Lazygit installation complete"
echo "  --> Lazygit found at: $(which lazygit)"
echo "  --> Lazygit version: $(lazygit --version)"

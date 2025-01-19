#!/bin/bash

echo
echo "----------------- NEOVIM INSTALL -----------------"

# Prompt for confirmation
while true; do
    read -p "--> Install nvim? (y/n) " -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> nvim won't get installed"
        # handle exits from shell or function but don't exit interactive shell
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

# Detect if nvim already exists
if command -v nvim &> /dev/null; then
    current_version=$(nvim --version | head -n1)
    echo "  --> Found $(which nvim)"
    echo "  --> nvim is already installed ($current_version). "
    while true; do
        read -p "  --> Reinstall nvim? (y/n) " -n 1 -r
        echo    # Move to a new line
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # delete potentially existing config
            rm -rf $HOME/.local/bin/nvim
            rm -rf $HOME/.local/share/nvim
            rm -rf $HOME/.local/state/nvim
            break
        elif [[ $REPLY =~ ^[Nn]$ ]]; then
            echo "  --> nvim won't get reinstalled"
            # handle exits from shell or function but don't exit interactive shell
            [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
        fi
    done
fi

# Detect OS and architecture
if [[ "$(uname)" == "Darwin" ]]; then
    if [[ "$(uname -m)" == "arm64" ]]; then
        DOWNLOAD_SUFFIX="macos-arm64.tar.gz"
    else
        DOWNLOAD_SUFFIX="macos-x86_64.tar.gz"
    fi
elif [[ "$(uname)" == "Linux" ]]; then
  DOWNLOAD_SUFFIX="linux64.tar.gz"
else
    echo "  --> Unsupported operating system"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

# Create ~/.local/bin if it doesn't exist
mkdir -p $HOME/.local/bin

# Get the latest release URL
LATEST_URL=$(wget -qO- https://api.github.com/repos/neovim/neovim/releases/latest | \
             grep "browser_download_url.*nvim-${DOWNLOAD_SUFFIX}\"" | \
             cut -d '"' -f 4)

# Create a temporary directory
TMP_DIR=$(mktemp -d)

# Download and extract
echo "  --> Downloading Neovim from $LATEST_URL..."
wget -qO- "$LATEST_URL" | tar xzf - -C "$TMP_DIR"

# Move the nvim binary to ~/.local/bin
echo "  --> Installing Neovim to $HOME/.local/bin..."
mv "$TMP_DIR"/nvim-*/bin/nvim $HOME/.local/bin/

# Move the share directory for runtime files
mkdir -p $HOME/.local/share
mv "$TMP_DIR"/nvim-*/share/nvim $HOME/.local/share/

# Cleanup
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

echo "  --> Neovim installation complete!"
# Print version to confirm installation
echo "  --> Neovim version:  $($HOME/.local/bin/nvim --version | head -n1)"

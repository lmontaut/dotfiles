#!/bin/bash

echo
echo "----------------- CLI TOOLS -----------------"

install_rg() {
    echo "  --> Installing rg..."
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install ripgrep
    elif [[ "$(uname)" == "Linux" ]]; then
        if command -v apt &> /dev/null; then
            sudo apt-get install -y ripgrep
        fi

        # install failed because e.g. no root privileges
        if ! command -v rg &> /dev/null; then
            cargo install ripgrep
        fi
    else
        echo "  --> Unsupported operating system"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
    fi

    if command -v rg &> /dev/null; then
        echo "  --> rg installed at: $(which rg)"
        current_version=$(rg --version | head -n1)
        echo "  --> rg version: ($current_version)"
    fi
}

install_fzf() {
    echo "  --> Installing fzf..."
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install fzf
    elif [[ "$(uname)" == "Linux" ]]; then
        if command -v apt &> /dev/null; then
            sudo apt-get install -y fzf
        fi

        # install failed because e.g. no root privileges
        if ! command -v fzf &> /dev/null; then
            # Create ~/.local/bin if it doesn't exist
            mkdir -p $HOME/.local/bin

            TMP_DIR=$(mktemp -d)
            cd "$TMP_DIR"

            DOWNLOAD_SUFFIX="linux_amd64.tar.gz"

            LATEST_URL=$(wget -qO- https://api.github.com/repos/junegunn/fzf/releases/latest | \
                     grep "browser_download_url.*fzf-.*${DOWNLOAD_SUFFIX}\"" | \
                     cut -d '"' -f 4)

            # Download and extract
            echo "  --> Downloading fzf from $LATEST_URL..."
            wget -O fzf.tar.gz "$LATEST_URL"
            tar xf fzf.tar.gz fzf

            # Move the binary to ~/.local/bin
            echo "  --> Installing fzf to $HOME/.local/bin..."
            install -D fzf "${HOME}/.local/bin/fzf"

            # Cleanup
            cd - > /dev/null
            rm -rf "$TMP_DIR"
        fi
    else
        echo "  --> Unsupported operating system"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
    fi

    if command -v fzf &> /dev/null; then
        echo "  --> fzf installed at: $(which fzf)"
        current_version=$(fzf --version | head -n1)
        echo "  --> fzf version: ($current_version)"
    fi
}

install_fd() {
    echo "  --> Installing fd..."
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install fd
    elif [[ "$(uname)" == "Linux" ]]; then
        if command -v cargo &> /dev/null; then
            cargo install fd-find
        fi

        # in case install failed, try with apt
        if ! command -v fd &> /dev/null; then
            sudo apt-get install -y fd-find
        fi
    else
        echo "  --> Unsupported operating system"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
    fi

    if command -v fd &> /dev/null; then
        echo "  --> fd installed at: $(which fd)"
        current_version=$(fd --version | head -n1)
        echo "  --> fd version: ($current_version)"
    fi
}

install_sad() {
    echo "  --> Installing sad..."
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install sad
    elif [[ "$(uname)" == "Linux" ]]; then
        # Create ~/.local/bin if it doesn't exist
        mkdir -p $HOME/.local/bin

        TMP_DIR=$(mktemp -d)
        cd "$TMP_DIR"

        DOWNLOAD_SUFFIX="x86_64-unknown-linux-gnu.deb"

        LATEST_URL=$(wget -qO- https://api.github.com/repos/ms-jpq/sad/releases/latest | \
            grep "browser_download_url.*${DOWNLOAD_SUFFIX}\"" | \
            cut -d '"' -f 4)

        # Download and extract
        echo "  --> Downloading sad from $LATEST_URL..."
        wget -O sad.deb "$LATEST_URL"

        if command -v apt &> /dev/null; then
            sudo apt-get install ./sad.deb # system wide install to deal with dependencies
        fi

        # install failed because e.g. no root privileges
        if ! command -v sad &> /dev/null; then
            # Extract deb file
            ar x sad.deb
            tar xf data.tar.xz

            # Move the binary to the correct location
            mv usr/bin/sad $HOME/.local/bin/
        fi

        # Cleanup
        cd - > /dev/null
        rm -rf "$TMP_DIR"
    else
        echo "  --> Unsupported operating system"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
    fi

    if command -v sad &> /dev/null; then
        echo "  --> sad installed at: $(which sad)"
        current_version=$(sad --version | head -n1)
        echo "  --> sad version: ($current_version)"
    fi
}

install_delta() {
    echo "  --> Installing delta..."
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install git-delta
    elif [[ "$(uname)" == "Linux" ]]; then
        cargo install git-delta
    else
        echo "  --> Unsupported operating system"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
    fi

    if command -v delta &> /dev/null; then
        echo "  --> delta installed at: $(which delta)"
        current_version=$(delta --version | head -n1)
        echo "  --> delta version: ($current_version)"
    fi
}

install_npm() {
    echo "  --> Installing node and npm..."
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install node
    elif [[ "$(uname)" == "Linux" ]]; then
        # Download and install nvm:
        wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

        \. "$HOME/.nvm/nvm.sh"

        nvm install 22

        # # Source to take effect (for nvm command)
        # export NVM_DIR="$HOME/.config/nvm"
        # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # loads nvm
        # [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # nvm bash completion
        # echo "  --> If nvm install fails, just run: '$HOME/.config/nvm install 22' in your shell"
        #
        # # Download and install Node.js:
        # $HOME/.config/nvm install 22
    else
        echo "  --> Unsupported operating system"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
    fi

    if command -v npm &> /dev/null; then
        echo "  --> node version: $(node -v)"
        echo "  --> nvm current: $(nvm current)"
        echo "  --> npm version: $(npm -v)"
    fi
}

install_eza() {
    echo "  --> Installing eza..."
    cargo install eza

    if command -v eza &> /dev/null; then
        echo "  --> eza at: $(which eza)"
        echo "  --> eza version: $(eza --version | head -n1)"
    fi
}

install_bat() {
    echo "  --> Installing bat..."
    cargo install --locked bat

    if command -v bat &> /dev/null; then
        echo "  --> bat at: $(which bat)"
        echo "  --> bat version: $(bat --version | head -n1)"
    fi
}

# ---- ripgrep
echo
if command -v rg &> /dev/null; then
    echo "--> Found rg at: $(which rg)"
    current_version=$(rg --version | head -n1)
    echo "--> rg version: ($current_version)"
fi

while true; do
    read -p "--> Install rg (ripgrep)? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_rg
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> rg won't get installed"
        break;
    fi
done

# ---- fzf
echo
if command -v fzf &> /dev/null; then
    echo "--> Found fzf at: $(which fzf)"
    current_version=$(fzf --version)
    echo "--> fzf version: ($current_version)"
fi

while true; do
    read -p "--> Install fzf? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_fzf
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> fzf won't get installed"
        break;
    fi
done

# ---- fd
echo
if command -v fd &> /dev/null; then
    echo "--> Found fd at: $(which fd)"
    current_version=$(fd --version)
    echo "--> fd version: ($current_version)"
fi

while true; do
    read -p "--> Install fd? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_fd
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> fd won't get installed"
        break;
    fi
done

# ---- sad
echo
if command -v sad &> /dev/null; then
    echo "--> Found sad at: $(which sad)"
    current_version=$(sad --version)
    echo "--> sad version: ($current_version)"
fi

while true; do
    read -p "--> Install sad? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_sad
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> sad won't get installed"
        break;
    fi
done

# ---- delta
echo
if command -v delta &> /dev/null; then
    echo "--> Found delta at: $(which delta)"
    current_version=$(delta --version)
    echo "--> delta version: ($current_version)"
fi

while true; do
    read -p "--> Install delta? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_delta
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> delta won't get installed"
        break;
    fi
done

# ---- node and npm
echo
if command -v node &> /dev/null; then
    echo "--> Found node at: $(which node)"
    current_version=$(node --version)
    echo "--> node version: ($current_version)"
fi

if command -v npm &> /dev/null; then
    echo "--> Found npm at: $(which npm)"
    current_version=$(npm --version)
    echo "--> npm version: ($current_version)"
fi

while true; do
    read -p "--> Install node and npm? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_npm
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> node and npm won't get installed"
        break;
    fi
done

# ---- eza
echo
if command -v eza &> /dev/null; then
    echo "--> Found eza at: $(which eza)"
    current_version=$(eza --version | head -n1)
    echo "--> eza version: ($current_version)"
fi

while true; do
    read -p "--> Install eza (fancy ls)? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_eza
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> eza won't get installed"
        break;
    fi
done

# ---- bat
echo
if command -v bat &> /dev/null; then
    echo "--> Found bat at: $(which bat)"
    current_version=$(bat --version | head -n1)
    echo "--> bat version: ($current_version)"
fi

while true; do
    read -p "--> Install bat (fancy cat)? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_bat
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> bat won't get installed"
        break;
    fi
done

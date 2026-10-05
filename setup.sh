#!/bin/bash

echo "-----------------------------------------------------"
echo "----------------- LOU CONFIG SCRIPT -----------------"
echo "-----------------------------------------------------"
echo

# Note: only zsh and tmux install require root privileges
# This install works if git, wget and unzip are installed or the user has root privileges
# If these are not present, installing part of this setup is still possible
# (certain tools are accessible via github releases).
#
# Note: the current script, for linux, relies on apt.
# For other linux flavor, it's easy to detect if another package manager is available:
# Linux - using apt (Ubuntu/Debian)
# if command -v apt &>/dev/null; then
#   sudo apt-get install -y ...
# Linux - using dnf (Fedora/RHEL)
# if command -v dnf &>/dev/null; then
#   sudo dnf install -y ...
# Linux - using pacman (Arch)
# elif command -v pacman &>/dev/null; then
#   sudo pacman -Sy ...

# Global var dotfile dir so that downstream scripts can work w.r.t this root
# (the repo root, wherever the script is run from)
export DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Tools installed by this script land here; make them visible to later steps
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

source $DOTFILES_DIR/setup_scripts/utils.sh
detect_os

# First, setup OS
source $DOTFILES_DIR/setup_scripts/setup_os.sh

# Submodules (nvim config, projects-configs). Their URLs use ssh, so this needs
# a GitHub ssh key; on failure, add the key and re-run.
echo
echo "----------------- GIT SUBMODULES -----------------"
# Only submodules not checked out yet ('-' prefix): never reset existing ones
for sub in $(git -C "$DOTFILES_DIR" submodule status | awk '/^-/ {print $2}'); do
    echo "  --> Fetching submodule $sub"
    if ! git -C "$DOTFILES_DIR" submodule update --init --recursive -- "$sub"; then
        echo "  --> Could not fetch $sub (GitHub ssh key missing?). Add the key and re-run."
    fi
done

# Git config
source $DOTFILES_DIR/setup_scripts/link_gitconfig.sh

# Setup usefull folders
setup_base_folders

# Setup shell
echo
echo "----------------- SHELL SETUP -----------------"
if ! command -v zsh > /dev/null 2>&1; then
  source $DOTFILES_DIR/setup_scripts/setup_zsh.sh
fi
CURRENT_SHELL=$(basename "$SHELL")
echo "--> Setup script will be run inside $CURRENT_SHELL"
# SHELL_LOCAL_FILE: machine-specific, untracked shell config that installers
# may append to. ~/.zshrc is a symlink into this repo and must not be modified.
if [ "$CURRENT_SHELL" = "zsh" ]; then
  export SHELL_LOCAL_FILE="$HOME/.zshrc_local"
  source $DOTFILES_DIR/setup_scripts/link_zsh_config.sh
  source $DOTFILES_DIR/setup_scripts/setup_zsh_plugins.sh
elif [ "$CURRENT_SHELL" = "bash" ]; then
  export SHELL_LOCAL_FILE="$HOME/.bashrc"
  touch $SHELL_LOCAL_FILE
else
  echo "--> $CURRENT_SHELL is not supported"
  exit 1
fi

# Create workspace
create_workspace

# Tmux
source $DOTFILES_DIR/setup_scripts/setup_tmux.sh
source $DOTFILES_DIR/setup_scripts/link_tmux_config.sh
source $DOTFILES_DIR/setup_scripts/setup_tmux_plugins.sh

# Cargo
source $DOTFILES_DIR/setup_scripts/setup_cargo.sh

# Alacritty
source $DOTFILES_DIR/setup_scripts/setup_alacritty.sh
source $DOTFILES_DIR/setup_scripts/link_alacritty_config.sh

# Lazygit
source $DOTFILES_DIR/setup_scripts/setup_lazygit.sh
source $DOTFILES_DIR/setup_scripts/link_lazygit_config.sh

# Nerd fonts
source $DOTFILES_DIR/setup_scripts/setup_nerd_fonts.sh

# CLI tools (rg, fzf, fd, bat... used by the tv channels)
source $DOTFILES_DIR/setup_scripts/setup_cli_tools.sh

# Session tools: zoxide, jq, television (tv), sesh, worktrunk (wt)
source $DOTFILES_DIR/setup_scripts/setup_session_tools.sh
source $DOTFILES_DIR/setup_scripts/link_television_config.sh
source $DOTFILES_DIR/setup_scripts/link_worktrunk_config.sh

# AI coding agents: Claude Code, Codex
source $DOTFILES_DIR/setup_scripts/setup_ai_tools.sh
source $DOTFILES_DIR/setup_scripts/link_ai_config.sh

# Ranger
source $DOTFILES_DIR/setup_scripts/setup_ranger.sh

# Nvim
source $DOTFILES_DIR/setup_scripts/setup_nvim.sh
source $DOTFILES_DIR/setup_scripts/link_nvim_config.sh
source $DOTFILES_DIR/setup_scripts/setup_nvim_plugins.sh

# Conda
source $DOTFILES_DIR/setup_scripts/setup_conda.sh

echo
echo "----------------- DONE -----------------"
echo "--> Restart your shell (exec zsh) and tmux server to pick up the new config."
echo "--> In tmux: prefix + I installs the tmux plugins."

#!/bin/bash

echo "-----------------------------------------------------"
echo "----------------- LOU CONFIG SCRIPT -----------------"
echo "-----------------------------------------------------"
echo

source $PWD/setup_scripts/utils.sh
detect_os

exit 0

# Global var dotfile dir so that downstream scripts can work w.r.t this root
export DOTFILES_DIR=$PWD

# First, setup OS
source $DOTFILES_DIR/setup_scripts/setup_os.sh

# Setup usefull folders
setup_base_folders

# Setup shell
if ! command -v zsh > /dev/null 2>&1; then
  source $DOTFILES_DIR/setup_scripts/setup_zsh.sh
fi
CURRENT_SHELL=$(basename "$SHELL")
echo "--> Setup script will be run inside $CURRENT_SHELL"
if [ "$CURRENT_SHELL" = "zsh" ]; then
  SHELL_CONFIG_FILE="$HOME/.zshrc"
  source $DOTFILES_DIR/setup_scripts/link_zsh_config.sh
  # source $DOTFILES_DIR/setup_scripts/setup_zsh_plugins.sh
elif [ "$CURRENT_SHELL" = "bash" ]; then
  SHELL_CONFIG_FILE="$HOME/.bashrc"
else
  echo "--> $CURRENT_SHELL is not supported"
  exit 1
fi

# Tmux
source $DOTFILES_DIR/setup_scripts/setup_tmux.sh
source $DOTFILES_DIR/setup_scripts/link_tmux_config.sh
# source $DOTFILES_DIR/setup_scripts/setup_tmux_plugins.sh

# Create workspace
create_workspace

# Cargo
source $DOTFILES_DIR/setup_scripts/setup_cargo.sh

# Alacritty
source $DOTFILES_DIR/setup_scripts/setup_alacritty.sh
source $DOTFILES_DIR/setup_scripts/setup_alacritty_config.sh

# Lazygit

# Tmux sesionnizer
source $DOTFILES_DIR/setup_scripts/setup_tms.sh

# Nvim
# source $DOTFILES_DIR/setup_scripts/setup_nvim.sh
# source $DOTFILES_DIR/setup_scripts/link_nvim_config.sh

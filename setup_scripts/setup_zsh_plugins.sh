#!/bin/bash

echo
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "--> Found oh-my-zsh at: $HOME/.oh-my-zsh"
fi

# Prompt for confirmation
while true; do
    read -p "--> Install zsh plugins? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> zsh plugins won't get installed."
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

echo "  --> Installing zsh plugins..."

git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Create the custom themes directory if it doesn't exist
mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"

# Create the theme file
cat << 'EOF' > "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/lou-theme.zsh-theme"
PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=$'minilou %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)\n╰λ '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
EOF

echo "  --> Installed zsh plugins. Restart your shell or run: source ~/.zshrc"

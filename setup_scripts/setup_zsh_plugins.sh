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

# Get the actual file path if .zshrc is a symlink
ZSHRC_PATH=$(readlink "$HOME/.zshrc" || echo "$HOME/.zshrc")

# Update .zshrc to use the new theme
ZSHRC_CONTENT=$(cat "$ZSHRC_PATH")
if ! echo "$ZSHRC_CONTENT" | grep -q '^ZSH_THEME="lou-theme"'; then
    # Create a temporary file
    TEMP_FILE=$(mktemp)

    # Add theme line at the top, then the rest of the content
    echo 'ZSH_THEME="lou-theme" #important that this is set before loading oh-my-zsh' > "$TEMP_FILE"
    echo "$ZSHRC_CONTENT" | sed '/^ZSH_THEME=.*$/d' >> "$TEMP_FILE"

    # Backup original file
    cp "$ZSHRC_PATH" "$ZSHRC_PATH.bak"

    # Move temp file to the actual target file
    mv "$TEMP_FILE" "$ZSHRC_PATH"
fi

echo "  --> Installed zsh plugins. Restart your shell or run: source ~/.zshrc"

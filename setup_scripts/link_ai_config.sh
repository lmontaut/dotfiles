#!/bin/bash

# Claude Code (~/.claude) and Codex (~/.codex) config.
# Those directories also hold sessions, history, auth and caches, so only
# individual config files are linked -- never the directories themselves.
#   linked:        instructions, statusline, slash commands, own skills
#   copied once:   settings.json / config.toml (the apps rewrite them with
#                  machine-specific state, so a link would churn the repo)

echo
while true; do
    read -p "--> Link the dofiles' Claude Code and Codex config files? (y/n) " -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "  --> No linking"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
    fi
done

# copy_if_missing <source> <destination>
copy_if_missing () {
    if [ -e "$2" ]; then
        echo "  --> Keeping existing $2 (base version: $1)"
    else
        mkdir -p "$(dirname "$2")"
        cp "$1" "$2"
        echo "  --> Copied $1 to $2"
    fi
}

# ---- Claude Code
CLAUDE_SRC=$DOTFILES_DIR/claude/.claude
for f in CLAUDE.md COMMANDS.md FLAGS.md PRINCIPLES.md RULES.md MCP.md PERSONAS.md ORCHESTRATOR.md MODES.md statusline.sh; do
    link_config "$CLAUDE_SRC/$f" "$HOME/.claude/$f"
done
link_config "$CLAUDE_SRC/commands/sc" "$HOME/.claude/commands/sc"
for skill in "$CLAUDE_SRC"/skills/*/; do
    skill=$(basename "$skill")
    link_config "$CLAUDE_SRC/skills/$skill" "$HOME/.claude/skills/$skill"
done
copy_if_missing "$CLAUDE_SRC/settings.json" "$HOME/.claude/settings.json"

# ---- Codex
CODEX_SRC=$DOTFILES_DIR/codex/.codex
link_config "$CODEX_SRC/AGENTS.md" "$HOME/.codex/AGENTS.md"
copy_if_missing "$CODEX_SRC/config.toml" "$HOME/.codex/config.toml"

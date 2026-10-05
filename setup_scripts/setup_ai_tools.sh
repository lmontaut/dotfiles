#!/bin/bash

# AI coding agents, both via their official installers (macOS and Linux, no root).
#   Claude Code: native build in ~/.local/share/claude, `claude` linked in ~/.local/bin
#   Codex:       standalone build in ~/.codex/packages, `codex` linked in ~/.local/bin
# Both keep themselves up to date.

echo
echo "----------------- AI CODING TOOLS (claude code, codex) -----------------"

install_claude_code() {
    curl -fsSL https://claude.ai/install.sh | bash
}

install_codex() {
    curl -fsSL https://chatgpt.com/codex/install.sh | sh
}

ask_install "Claude Code" claude install_claude_code
ask_install "Codex" codex install_codex

if command -v claude &> /dev/null || command -v codex &> /dev/null; then
    echo
    echo "--> Run 'claude' / 'codex' once to log in."
fi

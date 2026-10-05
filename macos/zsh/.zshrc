source $HOME/.zshrc_config

alias pixi-simple='pixi shell --manifest-path ~/workspace/simple-workspace/pixi.toml'
alias psimple='pixi shell --manifest-path ~/workspace/simple-workspace/pixi.toml'

# Machine-local additions (written by setup.sh, not tracked)
[ -f "$HOME/.zshrc_local" ] && source "$HOME/.zshrc_local"

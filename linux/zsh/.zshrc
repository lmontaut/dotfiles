# If you come from bash you might have to change your $PATH.
ZSH_DISABLE_COMPFIX=true
export PATH=$HOME/bin:/usr/local/bin:$PATH
# just executable on linux
export PATH=$HOME/software/bin:$PATH
# Cargo
. "$HOME/.cargo/env"

export XDG_CONFIG_HOME="$HOME/.config"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="robbyrussell"

plugins=(git ssh-agent zsh-autosuggestions)
zstyle :omz:plugins:ssh-agent lazy yes
source $ZSH/oh-my-zsh.sh

# -------- Aliases --------
alias open="xdg-open"
alias lum05="xrandr --output eDP --brightness 0.5"
alias lum10="xrandr --output eDP --brightness 1.0"
alias lum15="xrandr --output eDP --brightness 1.5"
alias lum="xrandr --output eDP --brightness"

# Make/CMake
alias mkdirr='mkdir builds/build-release-$(echo $CONDA_DEFAULT_ENV)'
alias mkdird='mkdir builds/build-debug-$(echo $CONDA_DEFAULT_ENV)'
alias lcompr='ln -sf builds/build-release-$(echo $CONDA_DEFAULT_ENV)/compile_commands.json ./'
alias lcompd='ln -sf builds/build-debug-$(echo $CONDA_DEFAULT_ENV)/compile_commands.json ./'
alias cmaker='cmake -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX -DCMAKE_BUILD_TYPE=Release -DCMAKE_SYSTEM_PREFIX_PATH=$CONDA_PREFIX -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_COMPILER_LAUNCHER=ccache'
alias cmaked='cmake -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX -DCMAKE_BUILD_TYPE=Debug -DCMAKE_SYSTEM_PREFIX_PATH=$CONDA_PREFIX -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_COMPILER_LAUNCHER=ccache'
# Conda
alias ca="conda activate"
alias ma="mamba activate"
# Tmux
alias tat="tmux attach -t"
alias tls="tmux ls"
alias tname="tmux rename-window -t"
# Vim
#alias vi="vim"
alias vim="nvim"

# Exports
export VISUAL=nvim;
export EDITOR=nvim;
export CMAKE_COLOR_DIAGNOSTICS=1
export CMAKE_EXPORT_COMPILE_COMMANDS=1

# Git
alias lg="lazygit"
alias gfix='git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"'
alias gfa="git fetch --all"
alias gs="git status"
alias ga="git add -p"
alias gc="git commit -v -p"
alias gl="git log --oneline"
alias gll="git log -p"
alias gp="git push"
alias gupstream="git branch --set-upstream-to"
alias gr="git reflog"
alias grl="git reflog -p"
alias gspush="git stash push --keep-index --message"
alias gspop="git stash pop --index"
alias gd="git diff"
alias gr="git rebase -i"
alias gb="git branch -vv"

# Safe rm
alias rm="rm -i"

#if ! type "$exa" > /dev/null; then
#  alias grep="rg"
#  alias top="gtop"
#  alias ls="exa"
#  alias du="dust"
#  alias df="duf"
#  alias cat="bat"
#  alias find="fd"
#fi

# export PATH="$PATH:/Users/louis/.dotnet/tools"
# export FrameworkPathOverride=/Library/Frameworks/Mono.framework/Versions/Current/Commands/mono
alias nvim-server="nvim --listen /tmp/nvimsocket"
xset r rate 300 50

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/lou/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/lou/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/lou/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/lou/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


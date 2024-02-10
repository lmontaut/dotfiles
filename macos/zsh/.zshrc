# If you come from bash you might have to change your $PATH.
ZSH_DISABLE_COMPFIX=true
export PATH=$HOME/bin:/usr/local/bin:usr/bin:$PATH
# . "$HOME/.cargo/env"
export PATH=$HOME/.config/emacs/bin:$PATH
export PATH=$HOME/mambaforge/bin:$PATH
export PATH=$HOME/.local/scripts:$PATH
# Neomvim
export PATH=$HOME/neovim/bin:$PATH

export XDG_CONFIG_HOME="$HOME/.config"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="robbyrussell"

plugins=(git ssh-agent gpg-agent zsh-autosuggestions)
zstyle :omz:plugins:ssh-agent lazy yes
source $ZSH/oh-my-zsh.sh

# Kill gpg-agent
alias gpg-kill="gpgconf --kill gpg-agent"

# -------- Aliases --------
alias audio="alsamixer"
alias picom="picom --config ~/.config/picom.conf -b"
alias ipi="ipython -i"
alias meshcat="chromium http://127.0.0.1:7000/static/"
alias lum05="xrandr --output eDP-1 --brightness 0.5"
alias lum10="xrandr --output eDP-1 --brightness 1.0"
alias lum15="xrandr --output eDP-1 --brightness 1.5"
alias cl="clear"
# alias open="xdg-open"
alias del_emacs="bash ~/dotfiles/emacs/.config/emacs/del_config.sh"
alias jupytervim="pip install jupyterlab-vim jupyterlab-vimrc"
# Make/CMake
alias mkdirr='mkdir builds/build-release-$(echo $CONDA_DEFAULT_ENV)'
alias mkdird='mkdir builds/build-debug-$(echo $CONDA_DEFAULT_ENV)'
alias lcompr='ln -sf builds/build-release-$(echo $CONDA_DEFAULT_ENV)/compile_commands.json ./'
alias lcompd='ln -sf builds/build-debug-$(echo $CONDA_DEFAULT_ENV)/compile_commands.json ./'
alias cmaker='cmake -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX -DCMAKE_BUILD_TYPE=Release -DCMAKE_SYSTEM_PREFIX_PATH=$CONDA_PREFIX -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_COMPILER_LAUNCHER=ccache'
alias cmaked='cmake -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX -DCMAKE_BUILD_TYPE=Debug -DCMAKE_SYSTEM_PREFIX_PATH=$CONDA_PREFIX -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_COMPILER_LAUNCHER=ccache'
alias code="/Applications/Visual\\ Studio\ Code.app/Contents/MacOS/Electron"
# Mamba
alias ma="mamba activate"
alias mi="mamba install"
# Tmux
alias tat="tmux attach -t"
alias tls="tmux ls"
alias tname="tmux rename-window -t"
# Vim
alias vi="vim"
alias vim="nvim"

# Exports
export VISUAL=nvim;
export EDITOR=nvim;
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
export CMAKE_COLOR_DIAGNOSTICS=1
export CMAKE_EXPORT_COMPILE_COMMANDS=1

# Git
alias lg="lazygit"
alias gfix='git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"'
alias gfa="git fetch --all"
alias gstatus="git status"
alias gadd="git add -p"
alias gcommit="git commit -v -p"
alias glog="git log --oneline"
alias gllog="git log -p"
alias gp="git push"
alias gupstream="git branch --set-upstream-to"
alias greflog="git reflog"
alias grl="git reflog -p"
alias gspush="git stash push --keep-index --message"
alias gspop="git stash pop --index"
alias gdiff="git diff"
alias grebase="git rebase -i"
alias gbranch="git branch -vv"
alias gsinit="git submodule update --init"

# Safe rm
alias rm="rm -i"

# alias for ldd
alias ldd="otool"

if ! type "$exa" > /dev/null; then
  alias grep="rg"
  # alias top="gtop"
  alias top="btop"
  alias ls="exa"
  alias du="dust"
  alias df="duf"
  alias cat="bat"
  # alias find="fd"
fi

# export PATH="$PATH:/Users/louis/.dotnet/tools"
# export FrameworkPathOverride=/Library/Frameworks/Mono.framework/Versions/Current/Commands/mono
eval "$(/opt/homebrew/bin/brew shellenv)"
alias nvim-server="nvim --listen /tmp/nvimsocket"
alias llvm-clang="/opt/homebrew/opt/llvm/bin/clang"

# Export C/C++ compiler
export CXX="ccache /usr/bin/clang++"
export CC="ccache /usr/bin/clang"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/louis/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/louis/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/louis/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/louis/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/louis/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/Users/louis/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<


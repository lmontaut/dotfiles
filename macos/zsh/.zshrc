# If you come from bash you might have to change your $PATH.
ZSH_DISABLE_COMPFIX=true

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH=$HOME/bin:/usr/local/bin:usr/bin:$PATH
export PATH=$HOME/.config/emacs/bin:$PATH
export PATH=$HOME/.local/scripts:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.pixi/bin:$PATH

export XDG_CONFIG_HOME="$HOME/.config"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="robbyrussell"

plugins=(git ssh-agent gpg-agent zsh-autosuggestions)
zstyle :omz:plugins:ssh-agent lazy yes
source $ZSH/oh-my-zsh.sh

# Kill ssh/gpg-agent
alias gpg-kill="gpgconf --kill gpg-agent"
alias ssh-kill="ssh-agent -k"

# -------- Aliases --------
# Misc
alias ipi="ipython -i"
alias cl="clear"
alias del_emacs="bash ~/dotfiles/emacs/.config/emacs/del_config.sh"
alias jupytervim="pip install jupyterlab-vim jupyterlab-vimrc"

# Conda
alias ca="conda activate"
alias ci="conda install"
alias cic="conda install -c conda-forge"

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
alias gsinit="git submodule update --init --recursive"
alias gcp="git cherry-pick"
precom() {
    pre-commit run --files $(git ls-files -m)
}

# Safe rm
alias rm="rm -i"

# alias for ldd
alias ldd="otool"

if ! type "$eza" > /dev/null; then
  alias grep="rg"
  alias top="btop"
  alias ls="eza"
  alias du="dust"
  alias df="duf"
  alias cat="bat"
  # alias top="gtop"
  # alias find="fd"
fi

# Export C/C++ compiler
# Bad idea with apple because ccache comes from brew and introduces weird bugs due
# to it not using the right stdlib...
# export CXX="ccache /usr/bin/clang++"
# export CC="ccache /usr/bin/clang"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/louis/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/louis/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/louis/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/louis/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

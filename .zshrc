# If you come from bash you might have to change your $PATH.
ZSH_DISABLE_COMPFIX=true
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="robbyrussell"

plugins=(git)
source $ZSH/oh-my-zsh.sh


# -------- PATHS ----------
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/lou/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/lou/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/lou/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/lou/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# I guess this is usefull ? Can't remember
# export PATH=/usr/local/bin:$PATH
# export PATH=$HOME/installed_libs/bin:$PATH
# export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
# export PYTHONPATH=/usr/local/lib/python3.8/site-packages:$PYTHONPATH
# export CMAKE_PREFIX_PATH=/usr/local:$CMAKE_PREFIX_PATH

# Picom path
# export PATH=$HOME/pkgs_source/picom/build/src:$PATH

# Doom Emacs path 
# export PATH=$HOME/.emacs.d/bin:$PATH
# export PATH=$HOME/.doom.d/bin:$PATH

# Zotero path
export PATH=$HOME/libs/zotero:$PATH
export PATH=$HOME/.local/share/applications:$PATH

# -------- Aliases --------
alias audio="alsamixer"
alias vi="vim"
alias vim="nvim"
alias picom="picom --config ~/.config/picom.conf -b"
alias tat="tmux attach -t"
alias tls="tmux ls"
alias lum05="xrandr --output eDP-1 --brightness 0.5"
alias lum10="xrandr --output eDP-1 --brightness 1.0"
alias lum15="xrandr --output eDP-1 --brightness 1.5"
alias ca="conda activate"
alias open="xdg-open"
alias ip="ipython"
alias orga="cd ~/orga"
# . "$HOME/.cargo/env"
 export VISUAL=lvim;
 export EDITOR=lvim;

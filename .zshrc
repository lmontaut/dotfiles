# If you come from bash you might have to change your $PATH.
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

# Pinocchio croc etc path
export LD_LIBRARY_PATH=/opt/openrobots/lib:$LD_LIBRARY_PATH
export PYTHONPATH=/opt/openrobots/lib/python3.8/site-packages:$PYTHONPATH # Adapt your desired python version here
export CMAKE_PREFIX_PATH=/opt/openrobots:$CMAKE_PREFIX_PATH
export CMAKE_PREFIX_PATH=/opt/openrobots/lib/cmake/eigenpy/:$CMAKE_PREFIX_PATH

# I guess this is usefull ? Can't remember
export PATH=/usr/local/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PYTHONPATH=/usr/local/lib/python3.8/site-packages:$PYTHONPATH
export CMAKE_PREFIX_PATH=/usr/local:$CMAKE_PREFIX_PATH

# Picom path
export PATH=$HOME/pkgs_source/picom/build/src:$PATH

# -------- Aliases --------
alias audio="alsamixer"
alias vim="nvim"
alias picom="picom --config ~/.config/picom.conf -b"

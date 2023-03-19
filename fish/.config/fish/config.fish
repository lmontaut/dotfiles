# Find brew
eval "$(/opt/homebrew/bin/brew shellenv)" 

# Find cargo and other cargo utilities
set -gx PATH "$HOME/.cargo/bin" $PATH;

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/louis/mambaforge/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
alias ca="conda activate"
alias ma="mamba activate"

# -- Better cli tooling
alias grep="rg"
alias top="gtop"
alias ls="exa"
alias du="duf"
alias cat="bat"

# -------- Aliases --------
alias audio="alsamixer"
alias picom="picom --config ~/.config/picom.conf -b"
alias cl="clear"
alias gfix='git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"'
alias ll='ls -la'

# -- Python
alias ipi="ipython -i"
alias meshcat="chromium http://127.0.0.1:7000/static/"
alias jupytervim="pip install jupyterlab-vim jupyterlab-vimrc"

# -- Tmux
alias tat="tmux attach -t"
alias tls="tmux ls"
alias tname="tmux rename-window -t"

# -- Git
alias lg="lazygit"

# -- Vim
alias vi="vim"
alias vim="nvim"

# -- CMake/Make
alias cmaker="cmake -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX -DCMAKE_BUILD_TYPE=Release -DCMAKE_SYSTEM_PREFIX_PATH=$CONDA_PREFIX -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_COMPILER_LAUNCHER=ccache"
alias buildr="echo rm -rf build_release && rm -rf build_release && echo mkdir build_release && mkdir build_release && echo cd build_release && cd build_release && echo cmaker .. && cmaker ..  && echo cp compile_commands.json ../ && cp compile_commands.json ../ && echo cd .. && cd .."
alias cmaked="cmake -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX -DCMAKE_BUILD_TYPE=Debug -DCMAKE_SYSTEM_PREFIX_PATH=$CONDA_PREFIX -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_COMPILER_LAUNCHER=ccache"
alias buildd="echo rm -rf build_debug && rm -rf build_debug && echo mkdir build_debug && mkdir build_debug && echo cd build_debug && cd build_debug && echo cmaked .. && cmaked ..  && echo cd .. && cd .."
alias make="make -j8"

# -- Rapid access to dotfiles
alias cdd="cd ~/dotfiles"

# -- Exports
export VISUAL=nvim;
export EDITOR=nvim;
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

export CMAKE_COLOR_DIAGNOSTICS=1
export CMAKE_EXPORT_COMPILE_COMMANDS=1
# export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# Safe rm
alias rm="rm -i"

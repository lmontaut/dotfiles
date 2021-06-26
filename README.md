## My config file for fresh linux install

Included in config files/Needed to install:
- i3wm
    - i3-gaps see doc for install: https://github.com/Airblader/i3/wiki/Installation
        - There are ppa, pull them i.e `sudo add-apt-repository -y ppa:regolith-linux/stable`
        - Then `sudo apt-get update` && `sudo apt-get install i3-gaps`
    - Check the config file for installs/modification.
        - For example, touchpad settings are modified / compton is used for gui stuff
        - Brigthness is modified etc
- zsh & oh-my-zsh
- tmux
- neovim
    - Install from source: `https://github.com/neovim/neovim`
    - `sudo apt-get install xclip` for clipboard + `set clipboard+=unamedplus`
    - For coc, python can cause problems:
        - Need to create a `.config/nvim/coc-settings.json`
        - Need to say: `"python.pythonPath": "python"`
        - This `python` will be the one used by `which python`. So make sure it uses the python from env you want
        - Install `:CocInstall coc-jedi`
    - For coc, c++ can cause problems:
        - Need a language server such as `clangd`
        - Install clangd, then `:CocInstall coc-clangd`
        - CocCommand clandg.install
Regarding the looks of the terminal, compton is required to add transparency. Otherwise, any terminal emulator will do.

Git clone this repo in `$HOME` folder then simply dot a `ln -sf $HOME/dotfiles/file-to-link $HOME/location-path-to-link`.
It should be is as simple as doing a `ln -sf $HOME/dotfiles/* $HOME/` as the structure in `dotfiles` is the same as the structure needed for config files to work in `$HOME`.
glhf


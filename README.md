# Dotfiles
## Create symlinks with `stow`
Simply `git clone` this repo and `cd` into it.<br/>
Then `stow --target=${HOME} */` (will target home dir) or `stow */` (will target parent dir).<br/>
You can also sync individual files i.e `stow nvim`.<br/>

## Installing programs
A list of programs is listed in `programs`.<br/>
Run `pacman -S < program/.pacman.list`.

[Polybar](https://github.com/polybar/polybar) probably needs to be installed (at least the themes).

Clone [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh): `git clone https://github.com/ohmyzsh/ohmyzsh $HOME/.oh-my-zsh`.

# NOTES / FIXES
C++ `clangd`:
    - First build your project `mkdir build && cd build && cmake .. (+ other cmake flags) && make install`
    - Then `cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ..` will create a `compile_commands.json` which clangd will use to provide completion.

`Treesitter` error (lots of lines underlined):
    - TSError is assigned to a color/behavior which is dependent only on the colorscheme used
    - We pick a colorscheme compatible with TS like gruvbox but in gruvbox, TSError underlines stuff which is MEGA annoying.
    - So go there: `vim ~/.vim/plugged/gruvbox.nvim/lua/gruvbox/plugins/highlights.lua` and delete line where there is TSError


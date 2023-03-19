# Dotfiles
## Create symlinks with `stow`
Simply `git clone` this repo and `cd` into it.<br/>
Then `stow --target=${HOME} */` (will target home dir) or `stow */` (will target parent dir).<br/>
You can also sync individual files i.e `stow nvim`.<br/>

## Installing programs
A list of programs is listed in `programs`.<br/>
Run `pacman -S < program/.pacman.list`.

For i3, [Polybar](https://github.com/polybar/polybar) probably needs to be installed (at least the themes).

## Very good set of tools
[Modern unix](https://github.com/ibraheemdev/modern-unix).
- rg (ripgrep)
- bat (cat replacement)
- duf (du replacement)
- exa (ls replacement)
- gtop (top replacement)

## NOTES / FIXES
[ ] Switch to zsh:
- install zsh `pacman -S zsh`
- activate and make permanent: `zsh && chsh -s /bin/zsh`
- better theme: oh-my-zsh: `git clone https://github.com/ohmyzsh/ohmyzsh.git  ~/.oh-my-zsh`
  - in `.zshrc`, use the robby theme
  - modify theme: `~/.oh-my-zsh/themes/robbyrussell.zsh-theme`
  - show full path: replace the `c` in `PROMPT += ...%c%...` by `~`

[ ] Switch to fish:
- Same process as with zsh

[ ] Polybar:
`git clone https://github.com/adi1090x/polybar-themes.git`

[ ] tmux plugin manager:
- First, stow tmux
- Then: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
- Launch a new tmux server, then prefix + I (C-a + I) -> automatic install

[ ] C++ `clangd`:
    - First build your project `mkdir build && cd build && cmake .. (+ other cmake flags) && make install`
    - Then `cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ..` will create a `compile_commands.json` which clangd will use to provide completion.

[ ] If `Treesitter` error has lots of lines underlined:
    - TSError is assigned to a color/behavior which is dependent only on the colorscheme used
    - We pick a colorscheme compatible with TS like gruvbox but in gruvbox, underlines (TSError or LSP reference or ...) stuff which is MEGA annoying.
    - So go there: `vim ~/.vim/plugged/gruvbox.nvim/lua/gruvbox/plugins/highlights.lua` and modify lines

[ ] LSP support nvim, visit [Lsp config](https://github.com/neovim/nvim-lspconfig), [server configs](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md).

## More plugins
Visit [awesome-neovim]("https://github.com/rockerBOO/awesome-neovim").
Wallpapers: [wallhaven](https://wallhaven.cc/)

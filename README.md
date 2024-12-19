# Dotfiles
## Basic config
Basic list of stuff that goes in the config:
- i3 (linux only) / amethyst (macos only)
  - [i3 + kde plasma](https://github.com/heckelson/i3-and-kde-plasma)
- alacritty
- zsh + oh-my-zsh + zsh-autosuggestions
- tmux
- neovim
- clang + ccache
- conda (i.e [miniforge](https://github.com/conda-forge/miniforge))
- rust/cargo
- tmux-sessionizer (cargo install ...)
- ranger
- lazygit

## Create symlinks with `stow`
Simply `git clone` this repo and `cd` into it.

Then `stow --target=${HOME} [...]` (will target home dir).

## Notes / Fixes
**Switch to zsh:**
- install zsh `pacman -S zsh`
- activate and make permanent: `zsh` **then** `chsh -s /bin/zsh` and `sudo chsh -s /bin/zsh`
- better theme: oh-my-zsh: `git clone https://github.com/ohmyzsh/ohmyzsh.git  ~/.oh-my-zsh`
  - in `.zshrc`, use the robby theme
  - modify theme: `~/.oh-my-zsh/themes/robbyrussell.zsh-theme`
  - show full path: replace the `c` in `PROMPT += ...%c%...` by `~`
- zsh autosuggestions:
  - Just do: `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
  - Or visit [zsh-autosuggestions INSTALL.md](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)

** Zsh theme**
```
PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=$'minilou %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)\n╰λ '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
```

**Rust/cargo install (needed for tmux-sessionizer):**
- `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

**Switch to fish:**
- Same process as with zsh

**Polybar:**
`git clone https://github.com/adi1090x/polybar-themes.git`

**Tmux plugin manager:**
- First, stow tmux
- Then: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
- Launch a new tmux server, then prefix + I (C-a + I) -> automatic install

**C/C++ `clangd`:**
- First build your project `mkdir build && cd build && cmake .. (+ other cmake flags) && make install`
- Then `cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ..` will create a `compile_commands.json` which clangd will use to provide completion.

**If `Treesitter` error has lots of lines underlined:**
- TSError is assigned to a color/behavior which is dependent only on the colorscheme used
- We pick a colorscheme compatible with TS like gruvbox but in gruvbox, underlines (TSError or LSP reference or ...) stuff which is MEGA annoying.
- So go there: `vim ~/.vim/plugged/gruvbox.nvim/lua/gruvbox/plugins/highlights.lua` and modify lines

**nvim LSP support:**
- visit [Lsp config](https://github.com/neovim/nvim-lspconfig), [server configs](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md).

## Nice set of cli tools
[Modern unix](https://github.com/ibraheemdev/modern-unix).
- rg (ripgrep)
- bat (cat replacement)
- duf (du replacement)
- exa (ls replacement)
- gtop (top replacement)
- delta (git viewer)
- ag (code searcher)
- cheat (i.e cheat ls)
- tldr (resuming man pages)
- fzf
    - vim $(fzf)
    - find * -type f | fzf > selected
- sad (sed replacement)
- procs (see pids)
- hyperfine (benchmarking from cli)

## More vim plugins
Visit [awesome-neovim]("https://github.com/rockerBOO/awesome-neovim").

## Installing programs for arch-based distro
A list of programs is listed in `programs`.

Note: it's probably a bad idea but you can do: `pacman -S < program/.pacman.list`.

For i3, [Polybar](https://github.com/polybar/polybar) probably needs to be installed (at least the themes).

# N/VIM keybindings
## Editor related
- `<ctrl>h/j/k/l`: pane navigation
- `<space>2`: pane zoom-in
- `<ctrl>c`: quit buffer
- `<ctrl>x`: quit all buffers but current one
- `<ctrl>s/a`: vertical/horizontal split
- `<ctrl>up/down/left/right`: pane resize
- `+ / _`: move lines around
- `<space>(/)`: previous/next buffer
- `<space>9/0`: previous/next tab
- `<ctrl>t`: opens file in new tab
- `cs + <thing_to_surround> + <thing_to_surround_by> `: vim-surround -
    ex: `csw"` takes `word` into `"word"`
    ex: `cs"'` replaces `""` by `''`

## Code folding
- `zn`: fold entire file
- `zm`: unfold entire file
- `za`: toggle current fold 

## LSP related
- `gd`: go to def
- `[d / ]d`: go to next/prev diagnostics
- `<ctrl>e`: shows diagnostics in box
- `<space>q`: diagnostics
- `K`: hover info
- `<space>rn`: rename / refactor
- `<space>f`: format file

## Autocompletion
- `<ctrl><space>`: toggle the autocompletion
- `<tab> / <shift><tab>`: scroll the autocomplete menu
- `<ctrl>p` & `<ctrl>n`: moves the doc of proposed autocompletion 

## Git
- `gs`: opens git menu
- `s / u`: stage/unstage
- `i`: shows modifications on file where cursor is
- `cc`: commit with message
- `gp`: git push

## Tree (Nvim tree)
- `<space>e`: toggle tree
- `<space>n`: find current file in tree
- `<space>r`: refresh tree
- `<space>o`: opens the file with `xdg-open` i.e the default software on
    system meant to open this type of file

## Fuzzy finder (Telescope)
- `<space>fh`: help finder for all vim functions
- `<ctrl>p`: fuzzy file finder
- `<ctrl>g`: live grep
- `<ctrl>b`: fuzzy find in buffers
- `<ctrl>f`: file browser
- `<ctrl>j/k`: up/down
- `<ctrl>s/a`: open file in vertical/horizontal flip
- `<ctrl>n`: open file in other tab

## Start menu (Startify)
- `<space>1`: open main menu
- `<space>[`: save current session
- `<space>]`: load session
- `<space>'`: save and close session

## Vista
- `<ctrl>i`: open vista

# Misc
- Update plugins: `:PlugUpdate`
- Checkhealth: `:checkhealth`
- `Pyright`:
    - Pyright is strong as it allows for type-checks which allow for much more lsp
        capabilities than other python lsp.
    - If you don't create a `pyrightconfig.json` in your project (same level as `.git`
        file), pyright will ONLY check types of libraries which produce `.pyi` files. It
        won't parse files to discover types and code structure.
    - If you put `useLibraryCodeForType` to true in `pyrightconfig.json`, it will TRY
        to extract type info out of library which don't have `.pyi` files. It will still
        use them if they are present.
    - Otherwise, you can run `pyright --createstub <name-library>` to let pyright
        attempt creating stub files of your library. You will likely have to manullay
        update these files as they may contain errors. You need to DELETE stubs files
        when re-running `pyright --createstub` for a library.
    - Some libraries still won't work for some reason like `pandas`. Run the createstub
        thing on them.

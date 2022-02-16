let g:nvim_tree_quit_on_open = 0 "0 by default, closes the tree when you open a file
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_disable_window_picker = 0 "0 by default, will disable the window picker.
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
let g:nvim_tree_create_in_closed_folder = 0 "1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
let g:nvim_tree_refresh_wait = 500 "1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'notify',
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }

nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue
lua << EOF
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    },
    number = false,
    relativenumber = false
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  }
}

local lib = require"nvim-tree.lib"
function get_file_name_at_cursor() 
  local node = lib.get_node_at_cursor()
  print(node.absolute_path)
end

vim.cmd [[
  command! NvimTreeEchoNodePath lua get_file_name_at_cursor()
]] 
EOF

" Desgined to open pdf, csv, png, jpg... files under NvimTree cursor
function! s:NvimOpenFileUnderCursor()
  redir => res
  execute ':NvimTreeEchoNodePath'
  redir END
  if empty(res)
    echoerr "no output"
  else
    let res = substitute(res, '\n', '', '')
    " echo 'fixed res:'
    " echo res
    " echo '!xdg-open'.' '.res

    exe '!xdg-open'.' '.res
  endif
endfunction
command! NvimOpenFileUnderCursor call s:NvimOpenFileUnderCursor()
nnoremap <silent> <leader>o :NvimOpenFileUnderCursor<CR><CR>


" LIST OF COMMANDS "
" - <CR> or o on .. will cd in the above directory
" - <C-]> will cd in the directory under the cursor
" - <BS> will close current opened directory or parent
" - type a to add a file. Adding a directory requires leaving a leading / at the end of the path.
"   - you can add multiple directories by doing foo/bar/baz/f and it will add foo bar and baz directories and f as a file
" - type r to rename a file
" - type <C-r> to rename a file and omit the filename on input
" - type x to add/remove file/directory to cut clipboard
" - type c to add/remove file/directory to copy clipboard
" - type y will copy name to system clipboard
" - type Y will copy relative path to system clipboard
" - type gy will copy absolute path to system clipboard
" - type p to paste from clipboard. Cut clipboard has precedence over copy (will prompt for confirmation)
" - type d to delete a file (will prompt for confirmation)
" - type D to trash a file (configured in setup())
" - type ]c to go to next git item
" - type [c to go to prev git item
" - type - to navigate up to the parent directory of the current file/directory
" - type s to open a file with default system application or a folder with default file manager (if you want to change the command used to do it see :h nvim-tree.setup under system_open)
" - if the file is a directory, <CR> will open the directory otherwise it will open the file in the buffer near the tree
" - if the file is a symlink, <CR> will follow the symlink (if the target is a file)
" - <C-v> will open the file in a vertical split
" - <C-x> will open the file in a horizontal split
" - <C-t> will open the file in a new tab
" - <Tab> will open the file as a preview (keeps the cursor in the tree)
" - I will toggle visibility of hidden folders / files
" - H will toggle visibility of dotfiles (files/folders starting with a .)
" - R will refresh the tree
" - Double left click acts like <CR>
" - Double right click acts like <C-]>

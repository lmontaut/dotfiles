nnoremap <leader>1 :Startify<CR>
nnoremap <leader>[ :SSave<CR>y
nnoremap <leader>] :SLoad<space>
nnoremap <leader>' :SSave<CR>y:SClose<CR>
let g:startify_session_dir = '~/.config/nvim/sessions'

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_bookmarks = [
            \ { 'c': '~/.config/i3/config' },
            \ { 'c': '~/.config/alacritty/alacritty.yml' },
            \ { 'c': '~/.config/nvim/init.vim' },
            \ { 'c': '~/.config/nvim/coc-settings.json' },
            \ { 'v': '~/.vim/plugins.vim' },
            \ { 'v': '~/.vim/keys.vim' },
            \ { 'v': '~/.vim/settings.vim' },
            \ { 'i': '~/.vimrc' },
            \ { 'z': '~/.zshrc' },
            \ ]

" Automatically restart a session
let g:startify_session_autoload = 1
" Let startify handle buffers
let g:startify_session_delete_buffers = 1

let g:startify_change_to_vcs_root = 1

" Automatically update sessions
let g:startify_session_persistence = 1

" Get rid of buffer on quit
let g:startify_enable_special = 0

let g:startify_custom_header = [
            \ '     ___          ___                                      ___          ___     ',
            \ '    /\  \        /\__\                                    /\  \        /\  \    ',
            \ '    \:\  \      /:/ _/_       ___                 ___    /::\  \       \:\  \   ',
            \ '     \:\  \    /:/ /\__\     /|  |               /|  |  /:/\:\  \       \:\  \  ',
            \ ' ___ /::\  \  /:/ /:/ _/_   |:|  |              |:|  | /:/  \:\  \  ___  \:\  \ ',
            \ '/\  /:/\:\__\/:/_/:/ /\__\  |:|  |              |:|  |/:/__/ \:\__\/\  \  \:\__\ ',
            \ '\:\/:/  \/__/\:\/:/ /:/  /__|:|__|            __|:|__|\:\  \ /:/  /\:\  \ /:/  / ',
            \ ' \::/__/      \::/_/:/  //::::\  \           /::::\  \ \:\  /:/  /  \:\  /:/  / ',
            \ '  \:\  \       \:\/:/  / ~~~~\:\  \          ~~~~\:\  \ \:\/:/  /    \:\/:/  /  ',
            \ '   \:\__\       \::/  /       \:\__\              \:\__\ \::/  /      \::/  /   ',
            \ '    \/__/        \/__/         \/__/               \/__/  \/__/        \/__/    ']

nnoremap <leader>1 :Startify<CR>
nnoremap <leader>[ :SSave<CR>y
nnoremap <leader>] :SLoad<space>
nnoremap <leader>' :SSave<CR>y:SClose<CR>
let g:startify_session_dir = '~/.config/nvim/sessions'

let g:startify_lists = [
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'files',     'header': ['   Files']            },
          \ ]

let g:startify_bookmarks = [
            \ { 'o': '~/orga/TODO.md' },
            \ { 'a': '~/dotfiles/cheatsheat.md' },
            \ { 'c': '~/dotfiles/.config/i3/config' },
            \ { 'i': '~/dotfiles/.config/nvim/init.vim' },
            \ { 'b': '~/dotfiles/.vim/keys.vim' },
            \ { 'p': '~/dotfiles/.vim/plugins.vim' },
            \ { 's': '~/dotfiles/.vim/settings.vim' },
            \ { 't': '~/dotfiles/.vim/my_snippets/tex.snippets' },
            \ { 'v': '~/dotfiles/.vimrc' },
            \ { 'z': '~/dotfiles/.zshrc' },
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

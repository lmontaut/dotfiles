" Calling the plugins
" They must be installed first w/ :PlugInstall command in vim

call plug#begin('~/.vim/plugged')
" Navigation tree
Plug 'preservim/nerdtree'

" Commenting
Plug 'tpope/vim-commentary'

" Themes
" Plug 'arcticicestudio/nord-vim'
" Plug 'gruvbox-community/gruvbox'
" Plug 'sainnhe/gruvbox-material'
Plug 'rktjmp/lush.nvim'
Plug 'npxbr/gruvbox.nvim'
" Plug 'folke/tokyonight.nvim'
" Plug 'dracula/vim', { 'as': 'dracula' }

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
" Plug 'ctrlpvim/ctrlp.vim'

"Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git integration
Plug 'tpope/vim-fugitive'
" Git little icons to show modif/add/rm
Plug 'mhinz/vim-signify'

" Autocompletion
if has("nvim")
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax for a bunch of languages
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
endif
call plug#end()

" Plugins settings
source ~/.vim/plugins/nerdtree.vim
source ~/.vim/plugins/vim-commentary.vim
source ~/.vim/plugins/telescope.vim
source ~/.vim/plugins/airline.vim
source ~/.vim/plugins/coc.vim
source ~/.vim/plugins/fugitive.vim

syntax on
set background=dark " or light if you want light mode
colorscheme gruvbox
set termguicolors

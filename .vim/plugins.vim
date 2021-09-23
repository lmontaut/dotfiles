" Calling the plugins
" They must be installed first w/ :PlugInstall command in vim

call plug#begin('~/.vim/plugged')

" --- Start menu
Plug 'mhinz/vim-startify'

" --- Commenting
Plug 'tpope/vim-commentary'

" --- Auto close things 
Plug 'tpope/vim-surround'

" --- Themes
Plug 'rktjmp/lush.nvim'
Plug 'npxbr/gruvbox.nvim'

" --- Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" --- Git integration
Plug 'tpope/vim-fugitive'

" Git little icons to show modif/add/rm
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

" --- Latex
Plug 'lervag/vimtex'

" --- Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" --- Snippets
Plug 'sirver/ultisnips'

if has("nvim")

" --- Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" --- LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neovim/nvim-lspconfig'

" Autocomplete
Plug 'hrsh7th/nvim-compe'

" --- Search LSP symbols
Plug 'liuchengxu/vista.vim'

" --- Syntax for a bunch of languages
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
endif
call plug#end()

source ~/.vim/plugins/coc.vim
" source ~/.vim/plugins/lsp.vim
" source ~/.vim/plugins/cmp.vim
source ~/.vim/plugins/vista.vim
source ~/.vim/plugins/telescope.vim
source ~/.vim/plugins/ultisnpis.vim
source ~/.vim/plugins/vim-markdown.vim
source ~/.vim/plugins/vimtex.vim
source ~/.vim/plugins/fugitive.vim
source ~/.vim/plugins/airline.vim
source ~/.vim/plugins/vim-commentary.vim
source ~/.vim/plugins/startify.vim

syntax on
colorscheme gruvbox
set termguicolors

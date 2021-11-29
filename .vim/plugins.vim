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

" --- Latex
Plug 'lervag/vimtex'

" --- Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" --- Snippets
Plug 'sirver/ultisnips'

if has("nvim")
Plug 'nvim-lua/plenary.nvim'
" --- Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
"
" Git little icons to show modif/add/rm
Plug 'lewis6991/gitsigns.nvim'


" --- Syntax for a bunch of languages
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
"
" --- Vim OrgMode
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'

" 2 possibilities for language server protocols: Coc or neovim native lsp
" ----- NATIVE LSP -----
Plug 'neovim/nvim-lspconfig'

" File explorer
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'onsails/lspkind-nvim'
" ----- END NATIVE LSP -----

" ----- COC -----
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
" --> coc release might not work, use yarn alternative. Yarn can be installed
"       in conda btw.
" ----- END COC -----
endif
"
" --- Search LSP symbols
Plug 'liuchengxu/vista.vim'
call plug#end()

if has("nvim")
    " If using native lsp
    source ~/.vim/plugins/cmp.vim
    source ~/.vim/plugins/lsp.vim
    source ~/.vim/plugins/nvim-tree.vim

    " If using CoC
    " source ~/.vim/plugins/coc.vim
    " nmap <leader>i :Vista coc<CR>

    " Usable with both lsp options
    source ~/.vim/plugins/tree-sitter.vim
    source ~/.vim/plugins/neorg.vim
    source ~/.vim/plugins/gitsigns.vim
    source ~/.vim/plugins/telescope.vim
    source ~/.vim/plugins/vista.vim " Need univeral ctags https://github.com/universal-ctags/ctags.git
    nmap <leader>i :Vista!!<CR>
endif
source ~/.vim/plugins/ultisnpis.vim
source ~/.vim/plugins/vim-markdown.vim
source ~/.vim/plugins/vimtex.vim
source ~/.vim/plugins/fugitive.vim
source ~/.vim/plugins/airline.vim
source ~/.vim/plugins/vim-commentary.vim
source ~/.vim/plugins/startify.vim

syntax on
colorscheme gruvbox
if has("nvim")
    set termguicolors
endif

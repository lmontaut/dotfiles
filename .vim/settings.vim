" set leader key
let g:mapleader = "\<Space>"

syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open
" set nowrap                              " Display long lines as just one line
" enable indentation
set breakindent

" ident by an additional 2 characters on wrapped lines, when line >= 40 characters, put 'showbreak' at start of line
set breakindentopt=shift:2,min:40,sbr

" append '>>' to indent
set showbreak=>>   
set wrap linebreak

" Specific to certain files
autocmd bufreadpre *.txt setlocal showbreak=""
autocmd bufreadpre *.tex setlocal showbreak=""
autocmd bufreadpre *.md setlocal showbreak=""
autocmd bufreadpre *.norg setlocal showbreak=""

" To get the context while scrolling
set scrolloff=8
set sidescrolloff=8

set foldmethod=indent
set foldlevel=99
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set cursorline              			      " Show the cursor position all the time
set cmdheight=1                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=4                           " Insert 4 spaces for a tab
set softtabstop=4
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=2                        " Always display the status line
set number                              " Line numbers
set relativenumber                      " Relative line numbers
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=300
set ttimeoutlen=0
set redrawtime=10000
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard+=unnamedplus               " Copy paste between vim and everything else
set modifiable
set showcmd             " show (partial) command in status line

set cindent
set cino=>2

" File-dependent indentation
autocmd Filetype vim setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype c setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype cpp setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype h setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype hpp setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype hxx setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" Remember folds: MUST specify the file type, otherwise it's a mess
augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.cpp,*.hpp,*.h,*.c,*.hxx,*.py,*.md,*.tex  mkview
  autocmd BufWinEnter *.cpp,*.hpp,*.h,*.c,*.hxx,*.py,*.md,*.tex silent! loadview
augroup END

" Remapping the leader key
let mapleader = " "

" Remaping this Esc key
imap jk <Esc>
imap kj <Esc>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Navigation tree
map <F2> :NERDTreeToggle<CR>

" Window resize
nnoremap <silent> <C-Up> :resize +5<CR>
nnoremap <silent> <C-Down> :resize -5<CR>
nnoremap <silent> <C-Right> :vertical resize +5<CR>
nnoremap <silent> <C-Left> :vertical resize -5<CR>
nnoremap <silent> <C-s> :vertical split<CR>
nnoremap <silent> <C-a> :split<CR>

" Window quit
nnoremap <silent> <C-c> :q<CR>

" Tab related
nnoremap <C-M-p> :tabnext<CR>
nnoremap <C-M-o> :tabprevious<CR>
nnoremap <silent> <leader>t <C-W>s<C-W>T

" Better tabbing
noremap > >>
noremap < <<

" Delete line
nnoremap ) dd

" Delete after word in edit mode
inoremap <C-e> <Esc>ldea

" Move lines around
nnoremap ddp
nnoremap + ddkP
vnoremap + :m '>+1<CR>gv=gv
vnoremap _ :m '<-2<CR>gv=gv

" Comment
vnoremap > >gv 
vnoremap < <gv

" Auto closing
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

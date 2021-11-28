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

" Window resize
nnoremap <silent> <C-Up> :resize +5<CR>
nnoremap <silent> <C-Down> :resize -5<CR>
nnoremap <silent> <C-Right> :vertical resize +5<CR>
nnoremap <silent> <C-Left> :vertical resize -5<CR>
nnoremap <silent> <C-s> :vertical split<CR>
nnoremap <silent> <C-a> :split<CR>

" Buffer quit
nnoremap <silent> <C-c> :bd<CR>

" Tab related
nnoremap <leader>0 :tabnext<CR>
nnoremap <leader>9 :tabprevious<CR>
nnoremap ) :bnext<CR>
nnoremap ( :bprevious<CR>
nnoremap <silent> <C-t> <C-W>s<C-W>T

" Better tabbing
noremap > >>
noremap < <<

" Delete line
nnoremap D dd

" Delete after word in edit mode
inoremap <C-e> <Esc>ldea

" Move lines around
nnoremap + ddkP
nnoremap _ ddp
vnoremap _ :m '>+1<CR>gv=gv
vnoremap + :m '<-2<CR>gv=gv

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

" Shift tab to unindent
inoremap <S-Tab> <C-d>

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <leader>2 :ZoomToggle<CR>


" Close all buffers except current one
nnoremap <C-x> :%bd\|e#<CR>

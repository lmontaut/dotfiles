" Remapping the leader key
let mapleader = " "

" Remaping this Esc key
imap jk <Esc>
imap kj <Esc>

" Open file eventhough it doesn't exist
map gf :edit <cfile><CR>

" Open file with default system program
nmap <leader>x :!xdg-open %<CR><CR>:bd<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Window resize
nnoremap <silent> <C-Up> :resize +20<CR>
nnoremap <silent> <C-Down> :resize -20<CR>
nnoremap <silent> <C-Right> :vertical resize +20<CR>
nnoremap <silent> <C-Left> :vertical resize -20<CR>
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

" Code folding
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction
nnoremap <silent> <leader>zj :call NextClosedFold('j')<CR>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<CR>
nnoremap zn :set foldlevel=0<CR>
nnoremap zm :set foldlevel=99<CR>
" --- Needed for it to work in Python 
autocmd bufreadpre *.py setlocal foldmethod=indent

" Close all buffers except current one
nnoremap <C-x> :%bd\|e#<CR>

" Automatically sources vim
nnoremap <leader>sv :source ~/.config/nvim/init.vim<CR>

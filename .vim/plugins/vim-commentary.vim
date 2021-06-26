function! UnmapCommentary()
  unmap gc
  nunmap gcc
  nunmap gcu
endfunction

xmap ( <Plug>Commentary
nmap ( <Plug>Commentary
omap ( <Plug>Commentary
nmap (( <Plug>CommentaryLine
nmap <leader>cl <Plug>ChangeCommentary
nmap <leader>cu <Plug>Commentary<Plug>Commentary

augroup key_clash
  autocmd!
  " unmap vim-commentary mappings
  autocmd VimEnter * if exists(":Commentary") | call UnmapCommentary() | endif
augroup END

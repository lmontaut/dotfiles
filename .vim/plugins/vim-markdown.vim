au FileType markdown syn region myMkdHeaderFold
        \ start="\v^\s*\z(\#{1,6})"
        \ skip="\v(\n\s*\z1\#)\@="
        \ end="\v\n(\s*\#)\@="ms=s-1,me=s-1
        \ fold contains=myMkdHeaderFold

au FileType markdown syn sync fromstart
au FileType markdown set foldmethod=syntax
au FileType markdown setlocal foldlevel=99

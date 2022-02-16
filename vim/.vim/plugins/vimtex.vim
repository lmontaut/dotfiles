" PDF Viewer
let g:vimtex_view_method = 'zathura'
let g:vimtex_enabled=1
let g:vimtex_quickfix_mode=0
let g:vimtex_complete_recursive_bib=1
let g:vimtex_fold_enabled =1
let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : 'build',
            \}
nnoremap \lv :VimtexView<CR>
" \le to toggle the compilation console

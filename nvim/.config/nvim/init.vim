if exists('g:vscode')
  source ~/.vimrc
else
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
  source ~/.vimrc
  set signcolumn=yes
endif

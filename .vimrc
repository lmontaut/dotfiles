set nocompatible
"filetype off                  " required
filetype indent plugin on
filetype plugin indent on    " required
"
" Install vim-plug if not already installed
if empty(glob("~/.vim/autoload/plug.vim"))
	" Ensure needed directories exist
	execute '!mkdir -p ~/.vim/plugged'
	execute '!mkdir -p ~/.vim/autoload'
	" Download the plugin manager
	execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" 1 - Vim related settings
source ~/.vim/settings.vim
" 2 - Plugins
source ~/.vim/plugins.vim
" 3 - Keybindings
source ~/.vim/keys.vim
 
" Transparent background - Needs to be in .vimrc for some reason
hi Normal guibg=NONE ctermbg=NONE
"-----------END-------------- 

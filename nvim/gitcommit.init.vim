call plug#begin(stdpath('data') . '/plugged-gitcommit')
Plug 'rakr/vim-one'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'wellle/targets.vim'
call plug#end()

source ~/dotfiles/nvim/theme.vim
source ~/dotfiles/nvim/settings.vim
source ~/dotfiles/nvim/colemak.vim
source ~/dotfiles/nvim/mappings.vim

set nonumber

" 1s/^$//e
goto 1
startinsert

" save and quit, enven during insert
map <C-e> :nohl<cr>:wq<cr>
imap <C-e> <esc>:nohl<cr>:wq<cr>

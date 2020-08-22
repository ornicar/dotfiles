call plug#begin(stdpath('data') . '/plugged-gitcommit')
Plug 'rakr/vim-one'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'wellle/targets.vim'
call plug#end()

source ~/dotfiles/nvim/theme.vim
source ~/dotfiles/nvim/settings.vim
source ~/dotfiles/nvim/colemak.vim
source ~/dotfiles/nvim/mappings.vim
source ~/dotfiles/nvim/unimpaired.vim

set nonumber

set omnifunc=rhubarb#Complete
set completeopt-=preview

put =nr2char(10) " add white line under cursor for visual comfort
goto 1
startinsert

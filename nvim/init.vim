call plug#begin(stdpath('data') . '/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'rakr/vim-one'
Plug 'itchyny/lightline.vim'
Plug 'kdheepak/lazygit.nvim'
Plug 'machakann/vim-sandwich'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'antoinemadec/coc-fzf'
Plug 'josa42/vim-lightline-coc'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'danro/rename.vim'
Plug 'mattn/vim-gist'
Plug 'ornicar/play2vim'
Plug 'wellle/targets.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'rust-lang/rust.vim'
call plug#end()


source ~/dotfiles/nvim/theme.vim
source ~/dotfiles/nvim/settings.vim
source ~/dotfiles/nvim/colemak.vim
source ~/dotfiles/nvim/mappings.vim
source ~/dotfiles/nvim/plugs.vim
source ~/dotfiles/nvim/lightline.vim
source ~/dotfiles/nvim/fzf.vim
source ~/dotfiles/nvim/coc.vim
source ~/dotfiles/nvim/unimpaired.vim
source ~/dotfiles/nvim/functions.vim
source ~/dotfiles/nvim/diff.vim
source ~/dotfiles/nvim/project.vim

call plug#begin(stdpath('data') . '/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'rakr/vim-one'
Plug 'itchyny/lightline.vim'
Plug 'codeindulgence/vim-tig'
Plug 'machakann/vim-sandwich'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/vim-lightline-coc'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'chiel92/vim-autoformat'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/Rename2'
Plug 'mattn/vim-gist'
Plug 'gre/play2vim'
Plug 'antoinemadec/coc-fzf'
Plug 'wellle/targets.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'stefandtw/quickfix-reflector.vim'
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

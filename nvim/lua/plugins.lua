return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'rakr/vim-one'
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }
  use { 'ibhagwan/fzf-lua', requires = { 'kyazdani42/nvim-web-devicons' } }
  use 'kdheepak/lazygit.nvim'
  use 'machakann/vim-sandwich'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-commentary'
  use 'danro/rename.vim'
  use 'mattn/vim-gist'
  use 'ornicar/play2vim'
  use 'wellle/targets.vim'
  use 'jremmen/vim-ripgrep'
  use 'stefandtw/quickfix-reflector.vim'
  use 'rust-lang/rust.vim'
  use { "hrsh7th/nvim-cmp", requires = { { "hrsh7th/cmp-nvim-lsp" } } }
  use {'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" }}
end)

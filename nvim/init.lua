require'packer'.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'rakr/vim-one'
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'kdheepak/lazygit.nvim'
  use 'machakann/vim-sandwich'
  -- use 'tpope/vim-fugitive' -- Git blame
  use 'tpope/vim-rhubarb' -- GBrowse
  use 'tpope/vim-vinegar' -- file browser
  use 'tpope/vim-commentary'
  use 'danro/rename.vim'
  use 'mattn/vim-gist'
  use 'ornicar/play2vim'
  use 'wellle/targets.vim'
  -- use 'jremmen/vim-ripgrep'
  use 'stefandtw/quickfix-reflector.vim'
  use 'rust-lang/rust.vim'
  use 'onsails/lspkind-nvim'
  use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})
  use({
    "hrsh7th/nvim-cmp",
    requires = { { "hrsh7th/cmp-nvim-lsp" }, { "hrsh7th/cmp-buffer" }, { "hrsh7th/cmp-path" }, { "saadparwaiz1/cmp_luasnip" }, { "petertriho/cmp-git" }, { "ray-x/cmp-treesitter" } },
  })
  use {'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" } }
end)

require('theme')
require('settings')
require('mappings')
require('functions')
require('project')
require('lsp')

require('plugins.lualine')
require('plugins.cmp')
require('plugins.metals')
require('plugins.treesitter')
require('plugins.telescope')
require('plugins.unimpaired')
require('plugins.others')

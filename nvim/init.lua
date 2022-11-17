require 'packer'.startup({ function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'neovim/nvim-lspconfig'
  use 'folke/tokyonight.nvim'
  use { 'nvim-lualine/lualine.nvim' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-context' -- display context (fun, class) at the top
  use { 'nvim-telescope/telescope.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'kdheepak/lazygit.nvim'
  use 'kylechui/nvim-surround'
  use 'nvim-tree/nvim-tree.lua'
  use 'tpope/vim-commentary'
  use 'danro/rename.vim'
  use 'mattn/vim-gist'
  use 'ornicar/play2vim'
  use 'wellle/targets.vim' -- adds various text objects - vimscript
  -- use 'jremmen/vim-ripgrep'
  use 'stefandtw/quickfix-reflector.vim'
  use 'rust-lang/rust.vim'
  use 'onsails/lspkind-nvim' -- lsp icons
  use({
    "hrsh7th/nvim-cmp",
    requires = { { "hrsh7th/cmp-nvim-lsp" }, { "hrsh7th/cmp-buffer" }, { "hrsh7th/cmp-path" },
      { "petertriho/cmp-git" }, { "ray-x/cmp-treesitter" } },
  })
  use 'mfussenegger/nvim-dap'
  use 'scalameta/nvim-metals'
  use 'lukas-reineke/lsp-format.nvim'
  use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
  use 'petertriho/nvim-scrollbar'
  use 'lewis6991/gitsigns.nvim'
  use 'kevinhwang91/nvim-hlslens'
  use 'rcarriga/nvim-notify'
  use 'RRethy/vim-illuminate'
  use 'zakharykaplan/nvim-retrail' -- trim trail whitespace
  use 'gbprod/yanky.nvim' -- yank ring
  use 'smjonas/inc-rename.nvim' -- LSP rename with preview
  use 'stevearc/dressing.nvim' -- better default nvim UI elements, using telescope
end,
  config = {
    autoremove = true,
  }
})

require('theme')
require('settings')
require('colemak')
require('mappings')
require('commands')
require('functions')
require('project')
require('lsp')

require('plugins.lualine')
require('plugins.cmp')
require('plugins.metals')
require('plugins.treesitter')
require('plugins.telescope')
require('plugins.scrollbar')
-- require('plugins.trouble')
require('plugins.tree')
require('plugins.unimpaired')
require('plugins.others')

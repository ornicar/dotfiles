require 'startup'
local util = require 'packer.util'
local map = vim.keymap.set

require 'packer'.startup({ function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'folke/tokyonight.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'kylechui/nvim-surround', config = function() require 'nvim-surround'.setup() end }
  use 'tpope/vim-commentary'

  use 'onsails/lspkind-nvim' -- lsp icons
  use({
    "hrsh7th/nvim-cmp",
    requires = { { "hrsh7th/cmp-buffer" }, { "petertriho/cmp-git" }, { "ray-x/cmp-treesitter" } },
  })
  use 'petertriho/nvim-scrollbar'
  use 'RRethy/vim-illuminate'
  use 'zakharykaplan/nvim-retrail' -- trim trail whitespace
  use { "gbprod/yanky.nvim", config = function() require 'yanky'.setup() end }
end,
  config = {
    autoremove   = true,
    package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack-gitcommit'),
    compile_path = util.join_paths(vim.fn.stdpath('data'), 'plugin', 'packer_compiled.gitcommit.lua'),
  }
})

require('theme')
require('settings')
require('colemak')
require('mappings')

require('plugins.cmp')
require('plugins.treesitter')
require('plugins.scrollbar')

map('n', '<leader>c<space>', '<Plug>CommentaryLine')
map('v', '<leader>c<space>', '<Plug>Commentary')

vim.opt.number = false
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = false
vim.opt.spell = true
vim.opt_global.complete:append("kspell")

vim.cmd([[
  goto 1
  startinsert
]])

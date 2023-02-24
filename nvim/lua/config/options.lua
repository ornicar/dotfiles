-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opt = vim.opt

opt.mouse = "" -- Enable mouse mode
opt.relativenumber = false -- Relative line numbers
opt.scrolloff = 6 -- Lines of context

opt.undofile = true -- Enable persistent undo (see also `:h undodir`)
opt.backup = false -- Don't store backup while overwriting the file
opt.writebackup = false -- Don't store backup while overwriting the file
opt.swapfile = false -- Use an SCM instead of swap files

opt.virtualedit = "block" -- Allow going past the end of line in visual block mode

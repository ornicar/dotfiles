-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opt = vim.opt

opt.mouse = nil
opt.relativenumber = false -- Relative line numbers
opt.scrolloff = 6 -- Lines of context
opt.backup = false -- Don't make a backup before overwriting a file.
opt.writebackup = false -- And again.
opt.swapfile = false -- Use an SCM instead of swap files

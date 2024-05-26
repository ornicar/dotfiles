-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- trim white space
-- vim.api.nvim_create_autocmd("BufWritePre", { command = "%s/\\s\\+$//e" })

vim.cmd([[
  " play2
  au BufRead,BufNewFile */conf/\(*\|\)routes set filetype=play2-routes
  au BufRead,BufNewFile */conf/*.conf setf hocon
]])

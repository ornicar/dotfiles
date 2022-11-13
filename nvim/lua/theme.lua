vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd.colorscheme('one')
vim.g.one_allow_italics = 1

vim.cmd([[
  call one#highlight('Normal', '', '#252525', 'none')
]])

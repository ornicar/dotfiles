local map = vim.keymap.set

-- === Plug rust ===

-- let g:rustfmt_autosave = 0 " coc does it

-- === Plug commentary ===

map('n', '<leader>c<space>', '<Plug>CommentaryLine')
map('v', '<leader>c<space>', '<Plug>Commentary')

-- === Plug BufStop ===

vim.g.BufstopKeys = "arstneio"

map('n', '<leader>mt', ':BufstopMode<CR>')

-- === lazygit ===

map('n', '<leader>gg', ':LazyGit<cr>', { silent = true })

vim.g.lazygit_floating_window_scaling_factor = 1

--- gitsigns

map('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<cr>')

--- surround

require("nvim-surround").setup({
})

--- notify

vim.notify = require("notify")

--- lsp lines

require("lsp_lines").setup({
})
vim.diagnostic.config({
  virtual_text = false, -- disable native error messages
  virtual_lines = true -- show line error messages
})
-- https://www.reddit.com/r/neovim/comments/w5h9tl/comment/ih9wh9b/?utm_source=reddit&utm_medium=web2x&context=3
-- vim.api.nvim_create_autocmd('InsertEnter', {
--   callback = function()
--     vim.diagnostic.hide()
--   end,
-- })
-- vim.api.nvim_create_autocmd('ModeChanged', {
--   pattern = 'i:*',
--   callback = function()
--     vim.diagnostic.show()
--   end,
-- })

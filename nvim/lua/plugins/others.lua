local map = vim.keymap.set

-- === Plug rust ===

-- let g:rustfmt_autosave = 0 " coc does it

-- === Plug commentary ===

map('n', '<leader>c<space>', '<Plug>CommentaryLine')
map('v', '<leader>c<space>', '<Plug>Commentary')

-- === Plug BufStop ===

vim.g.BufstopKeys = "arstneio"

map('n', '<leader>mt', ':BufstopMode<CR>')

-- === Plug vinegar ===

vim.g.netrw_liststyle = 3

-- === lazygit ===

map('n', '<leader>gg', ':LazyGit<cr>', { silent = true })

vim.g.lazygit_floating_window_scaling_factor = 1

--- surround

require("nvim-surround").setup({
})

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

--- scrollbar
require 'scrollbar'.setup({
  show_in_active_only = true,
  max_lines = 10000, -- disables if no. of lines in buffer exceeds this
  excluded_buftypes = {
    "terminal",
  },
  excluded_filetypes = {
    "prompt",
    "TelescopePrompt",
    "noice",
  },
  handlers = {
    diagnostic = true,
    search = true, -- Requires hlslens to be loaded
    gitsigns = true, -- Requires gitsigns.nvim
  },
})
require 'gitsigns'.setup()
require 'scrollbar.handlers.gitsigns'.setup()
require 'scrollbar.handlers.search'.setup({
  -- hlslens config overrides
})

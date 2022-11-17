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

require("nvim-surround").setup({})

--- notify

vim.notify = require("notify")

--- lsp lines

require("lsp_lines").setup({})
vim.diagnostic.config({
  virtual_text = false, -- disable native error messages
  virtual_lines = true -- show line error messages
})


require 'hlslens'.setup({})


require 'inc_rename'.setup({
  input_buffer_type = "dressing"
})
map("n", "<leader>rn", ":IncRename ")


require 'yanky'.setup({})
require 'telescope'.load_extension 'yank_history'
map("n", "<leader>mp", ":Telescope yank_history<cr>")
map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
map("n", "<c-n>", "<Plug>(YankyCycleForward)")
map("n", "<c-p>", "<Plug>(YankyCycleBackward)")

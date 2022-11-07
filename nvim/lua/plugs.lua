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

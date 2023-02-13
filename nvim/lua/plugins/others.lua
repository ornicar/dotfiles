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


require("nvim-surround").setup({})



require 'yanky'.setup({
    highlight = {
        timer = 200
    }
})
require 'telescope'.load_extension 'yank_history'
map("n", "<leader>mp", ":Telescope yank_history<cr>")
map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
map("n", "<c-n>", "<Plug>(YankyCycleForward)")
map("n", "<c-p>", "<Plug>(YankyCycleBackward)")
map("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
map("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")


-- ripgrep
map("n", "<leader>rg", ":Rg ")
map('n', '<leader>wg', ":Rg <C-R><C-W> ")


require('illuminate').configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        'treesitter',
        'regex',
    },
    -- delay: delay in milliseconds
    delay = 100,
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
    -- large_file_cutoff: number of lines at which to use large_file_config
    -- The `under_cursor` option is disabled when this cutoff is hit
    large_file_cutoff = 9999,
})


require('iswap').setup { keys = 'arstdhneio' }
map("n", "gw", ":ISwapWithRight<cr>")
map("n", "<leader>is", ":ISwap<cr>")

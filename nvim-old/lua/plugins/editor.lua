local map = vim.keymap.set

return {
    -- Add/change/delete surrounding delimiter pairs
    { 'kylechui/nvim-surround' },

    -- yank ring
    {
        'gbprod/yanky.nvim',
        opts = {
            highlight = { timer = 200 }
        },
        keys = {
            { "p",     "<Plug>(YankyPutAfter)",               mode = { "n", "x" } },
            { "P",     "<Plug>(YankyPutBefore)",              mode = { "n", "x" } },
            { "<c-n>", "<Plug>(YankyCycleForward)" },
            { "<c-p>", "<Plug>(YankyCycleBackward)" },
            { "]p",    "<Plug>(YankyPutIndentAfterLinewise)" },
            { "[p",    "<Plug>(YankyPutIndentBeforeLinewise)" },
        }
    },

    -- trim trail whitespace
    { 'zakharykaplan/nvim-retrail' },

    -- highlight occurences of word under the cursor
    {
        'RRethy/vim-illuminate',
        opts = {
            -- providers: provider used to get references in the buffer, ordered by priority
            providers = { 'treesitter', 'regex', },
            -- delay: delay in milliseconds
            delay = 100,
            -- under_cursor: whether or not to illuminate under the cursor
            under_cursor = true,
            -- large_file_cutoff: number of lines at which to use large_file_config
            -- The `under_cursor` option is disabled when this cutoff is hit
            large_file_cutoff = 9999,
        }
    },

    -- update buffers right from the quickfix!
    { 'stefandtw/quickfix-reflector.vim' },

    -- add various text objects - vimscript
    { 'wellle/targets.vim' },

    -- quickly rename current buffer
    { 'danro/rename.vim' },

    -- ripgrep
    {
        'jremmen/vim-ripgrep',
        keys = {
            { "<leader>rg", ":Rg " },
            { '<leader>wg', ":Rg <C-R><C-W> " },
        },
        cmd = 'Rg'
    },

    -- just 4 fun
    { "eandrju/cellular-automaton.nvim", cmd = "CellularAutomaton" }
}

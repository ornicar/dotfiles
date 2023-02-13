return {
    -- swap arguments and things
    {
        'mizlan/iswap.nvim',
        keys = {
            { "gw",         ":ISwapWithRight<cr>" },
            { "<leader>is", ":ISwap<cr>" },
        }
    },

    -- language comments - #TODO is this still necessary?
    { 'tpope/vim-commentary',
        keys = {
            { '<leader>c<space>', '<Plug>CommentaryLine' },
            { '<leader>c<space>', '<Plug>Commentary' },
        }
    },

    -- better rust support (?)
    {'rust-lang/rust.vim'},
}

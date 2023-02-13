return {
    -- plugin manager
    { "folke/lazy.nvim",                          version = "*" },
    'neovim/nvim-lspconfig',
    'nvim-telescope/telescope.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    'onsails/lspkind-nvim', -- lsp icons
    'scalameta/nvim-metals',
    'mfussenegger/nvim-dap', -- debugger
    'lukas-reineke/lsp-format.nvim', -- async code formatting
    'jose-elias-alvarez/null-ls.nvim', -- hook into nvim LSP
    -- use 'dstein64/vim-startuptime'
}

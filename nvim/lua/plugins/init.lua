return {
    'wbthomason/packer.nvim',
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'neovim/nvim-lspconfig',
    'folke/tokyonight.nvim',
    'nvim-lualine/lualine.nvim',
    { 'nvim-treesitter/nvim-treesitter',          run = ':TSUpdate' },
    'nvim-treesitter/nvim-treesitter-context', -- display context (fun, class) at the top
    'nvim-telescope/telescope.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    'kdheepak/lazygit.nvim',
    'kylechui/nvim-surround',
    'tpope/vim-commentary',
    'danro/rename.vim',
    'mattn/vim-gist',
    'wellle/targets.vim', -- adds various text objects - vimscript
    'jremmen/vim-ripgrep',
    'stefandtw/quickfix-reflector.vim',
    'rust-lang/rust.vim',
    'onsails/lspkind-nvim', -- lsp icons
    {
        "hrsh7th/nvim-cmp",
        requires = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
            "petertriho/cmp-git", "ray-x/cmp-treesitter" },
    },
    'scalameta/nvim-metals',
    'mfussenegger/nvim-dap', -- debugger
    'lukas-reineke/lsp-format.nvim', -- async code formatting
    'jose-elias-alvarez/null-ls.nvim', -- hook into nvim LSP
    'petertriho/nvim-scrollbar',
    'lewis6991/gitsigns.nvim',
    'ruanyl/vim-gh-line', -- git browse (<leader>gh)
    'rcarriga/nvim-notify',
    'RRethy/vim-illuminate',
    'zakharykaplan/nvim-retrail', -- trim trail whitespace
    'gbprod/yanky.nvim', -- yank ring
    'mizlan/iswap.nvim', -- swap arguments and things
    { "nvim-tree/nvim-tree.lua", opt = true, cmd = { "NvimTreeToggle" },
        setup = function() vim.keymap.set('n', '-', ':NvimTreeToggle<cr>') end,
        config = function() require("plugins.tree") end,
    },
    { "eandrju/cellular-automaton.nvim", opt = true, cmd = { "CellularAutomaton" } }
    -- use 'dstein64/vim-startuptime'
}

return {
    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "folke/neoconf.nvim", cmd = "Neoconf",                                config = true },
            { "folke/neodev.nvim",  opts = { experimental = { pathStrict = true } } },
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            {
                "hrsh7th/cmp-nvim-lsp",
                cond = function()
                  return require("lazyvim.util").has("nvim-cmp")
                end,
            },
        },
        ---@class PluginLspOpts
        opts = {
        }
    }
}

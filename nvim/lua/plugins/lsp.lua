return {
  -- language servers
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[7] = { "gh", vim.lsp.buf.hover, desc = "Hover" }
      keys[#keys + 1] = { "<leader>cl", vim.lsp.codelens.run, desc = "LSP code lens" }
      keys[#keys + 1] = { "<space>cq", vim.diagnostic.setqflist, desc = "Put diagnostics in quickfix" }
      keys[#keys + 1] = { "<space>cz", vim.diagnostic.reset, desc = "Reset diagnostics" }
    end,
    ---@class PluginLspOpts
    opts = {
      servers = {
        cssls = {},
        dartls = {},
        rust_analyzer = {},
        pyright = {},
      },
    },
  },

  -- formatters
  -- rm /run/user/1000/.prettierd
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   opts = function(_, opts)
  --     opts.debug = true
  --   end,
  -- },
}

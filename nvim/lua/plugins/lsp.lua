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

  -- scala lsp
  {
    "scalameta/nvim-metals",
    -- stylua: ignore
    keys = {
      {'<leader>me', function() require "telescope".extensions.metals.commands() end, desc="Metals commands"},
      {'<leader>mc', function() require "metals".compile_cascade() end, desc="Metals compile cascade"},
    },
  },
}

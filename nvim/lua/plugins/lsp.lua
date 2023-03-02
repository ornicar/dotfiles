return {
  -- language servers
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<leader>cl", vim.lsp.codelens.run, desc = "LSP code lens" }
      keys[#keys + 1] = { "<space>q", vim.diagnostic.setqflist, desc = "Put diagnostics in quickfix" }
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
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },

  -- debugger
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      {"<leader>dc", function() require "dap".continue({}) end},
      {"<leader>dr", function() require "dap".repl.toggle() end},
      {"<leader>dk", function() require "dap.ui.widgets".hover() end},
      {"<leader>dt", function() require "dap".toggle_breakpoint() end},
      {"<leader>do", function() require "dap".step_over() end},
      {"<leader>di", function() require "dap".step_into() end},
      {"<leader>dl", function() require "dap".run_last() end},
    },
  },
}

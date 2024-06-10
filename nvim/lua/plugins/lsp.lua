return {
  -- language servers
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- replace `{ "K", vim.lsp.buf.hover, desc = "Hover" }`
      keys[7] = { "gh", vim.lsp.buf.hover, desc = "Hover" }
      keys[#keys + 1] = { "<leader>cd", ":LspRestart<cr>", desc = "LSP restart" }
      keys[#keys + 1] = { "<leader>cl", vim.lsp.codelens.run, desc = "LSP code lens" }
      keys[#keys + 1] = { "<space>cq", vim.diagnostic.setqflist, desc = "Put diagnostics in quickfix" }
      keys[#keys + 1] = { "<space>cz", vim.diagnostic.reset, desc = "Reset diagnostics" }
    end,
    ---@class PluginLspOpts
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        lua_ls = {},
        nil_ls = {},
        cssls = {},
        vtsls = {
          enabled = false,
        },
        tsserver = {
          enabled = true,
          settings = {
            typescript = {},
            javascript = {},
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
      },
    },
  },

  -- scala lsp
  {
    "scalameta/nvim-metals",
    -- stylua: ignore
    keys = {
      { '<leader>me', function() require "telescope".extensions.metals.commands() end, desc = "Metals commands" },
      { '<leader>mc', function() require "metals".compile_cascade() end,               desc = "Metals compile cascade" },
    },
  },
}

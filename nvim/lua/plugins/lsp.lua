return {
  -- language servers
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- replace `{ "K", vim.lsp.buf.hover, desc = "Hover" }`
      keys[2] = {
        "ge",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "Goto Definition",
        has = "definition",
      }
      keys[3] = { "gn", vim.lsp.buf.references, desc = "References", nowait = true }
      keys[6] = { "gE", vim.lsp.buf.declaration, desc = "Goto Declaration" }
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
        ts_ls = {
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
}

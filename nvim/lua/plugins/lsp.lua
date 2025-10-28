return {
  -- language servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          -- stylua: ignore
          keys = {
            { "ge", function() Snacks.picker.lsp_definitions() end, desc = "Definition", has = "definition", },
            { "gE", vim.lsp.buf.declaration, desc = "Goto Declaration" },
            { "gn", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
            { "gh", vim.lsp.buf.hover, desc = "Hover" },
            { "<leader>cl", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "x" }, has = "codeLens" },
            { "<space>cq", vim.diagnostic.setqflist, desc = "Put diagnostics in quickfix" },
            { "<space>cz", vim.diagnostic.reset, desc = "Reset diagnostics" }
          },
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
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = function(_, opts)
  --     opts.inlay_hints = {
  --       enabled = false,
  --     }
  --     opts.servers = {
  --       lua_ls = {},
  --       nil_ls = {},
  --       cssls = {},
  --       vtsls = {
  --         enabled = false,
  --       },
  --       ts_ls = {
  --         enabled = true,
  --         settings = {
  --           typescript = {},
  --           javascript = {},
  --           completions = {
  --             completeFunctionCalls = true,
  --           },
  --         },
  --       },
  --       rust_analyzer = {},
  --     }
  --
  --     local keys = require("lazyvim.plugins.lsp.keymaps").get()
  --     -- disable lua/lazyvim/plugins/extras/editor/snacks_picker.lua and lazyvim/plugins/lsp/keymaps.lua
  --     keys[#keys + 1] = { "gd", false }
  --     keys[#keys + 1] = { "gD", false }
  --     keys[#keys + 1] = { "gr", false }
  --     keys[#keys + 1] = { "<leader>ss", false }
  --     keys[#keys + 1] = { "<leader>sS", false }
  --     keys[#keys + 1] = { "K", false }
  --     keys[#keys + 1] = { "<a-n>", false }
  --     keys[#keys + 1] = { "<a-p>", false }
  --     -- stylua: ignore
  --     keys[#keys + 1] = { "ge", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition", has = "definition", }
  --     keys[#keys + 1] = {
  --       "gn",
  --       function()
  --         Snacks.picker.lsp_references()
  --       end,
  --       desc = "References",
  --     }
  --     keys[#keys + 1] = { "gE", vim.lsp.buf.declaration, desc = "Goto Declaration" }
  --     keys[#keys + 1] = { "gh", vim.lsp.buf.hover, desc = "Hover" }
  --     keys[#keys + 1] = { "<leader>cl", vim.lsp.codelens.run, desc = "LSP code lens" }
  --     keys[#keys + 1] = { "<space>cq", vim.diagnostic.setqflist, desc = "Put diagnostics in quickfix" }
  --     keys[#keys + 1] = { "<space>cz", vim.diagnostic.reset, desc = "Reset diagnostics" }
  --   end,
  -- },
}

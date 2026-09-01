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
            { "<space>cz", vim.diagnostic.reset, desc = "Reset diagnostics" },
            { "K", "E", desc = "End" }, -- override K to go to end of WORD instead of hover, since hover is mapped to gh
          },
        },
        stylelint_lsp = {
          cmd = { "stylelint-lsp", "--stdio" },
        },
        ts_ls = {
          enabled = true,
          settings = {
            typescript = {
              preferences = {
                autoImportFileExcludePatterns = { "**/dist/**" },
                autoImportSpecifierExcludeRegexes = { ".*dist.*" },
              },
              exclude = {
                "node_modules",
                "dist",
                "*/dist/*",
                "dist/*",
                "dist/**",
              },
            },
            javascript = {},
            preferences = {
              autoImportFileExcludePatterns = { "**/dist/**" },
              autoImportSpecifierExcludeRegexes = { ".*dist.*" },
            },
            exclude = {
              "node_modules",
              "dist",
              "*/dist/*",
              "dist/*",
              "dist/**",
            },
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
      },
    },
  },
}

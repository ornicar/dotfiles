return {
  -- swap arguments and things
  {
    "mizlan/iswap.nvim",
    keys = {
      { "gw", ":ISwapWithRight<cr>" },
      { "<leader>is", ":ISwap<cr>" },
    },
    opts = {
      keys = "arstdhneio",
    },
  },

  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-e>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      })
    end,
  },

  -- syntax parser
  {
    "nvim-treesitter/nvim-treesitter",
    ---@type TSConfig
    opts = {
      highlight = {
        disable = function(_, bufnr) -- Disable in large buffers
          return vim.api.nvim_buf_line_count(bufnr) > 10000
        end,
      },
      -- stylua: ignore
      ensure_installed = {
        "scala", "haskell", "rust", "scss", "dart", "hocon", "bash", "help", "html", "javascript", "json", "lua",
        "markdown", "markdown_inline", "python", "query", "regex", "tsx", "typescript", "vim", "yaml",
      },
    },
  },
}

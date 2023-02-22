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
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-e>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-Space>"] = function()
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            cmp.complete()
          end
        end,
        ["<C-c>"] = cmp.mapping.abort(),
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

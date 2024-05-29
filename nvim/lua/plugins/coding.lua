return {
  -- swap arguments and things
  {
    "mizlan/iswap.nvim",
    keys = {
      { "gw",         ":ISwapWithRight<cr>", desc = "Swap two arguments" },
      { "<leader>is", ":ISwap<cr>",          desc = "Swap many arguments" },
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

  { "echasnovski/mini.pairs", enabled = false },

  -- surround
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "<space>sa",            -- Add surrounding in Normal and Visual modes
        delete = "<space>sd",         -- Delete surrounding
        find = "<space>sf",           -- Find surrounding (to the right)
        find_left = "<space>sF",      -- Find surrounding (to the left)
        highlight = "<space>sh",      -- Highlight surrounding
        replace = "<space>sr",        -- Replace surrounding
        update_n_lines = "<space>sn", -- Update `n_lines`
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" }
      }
    }
  }
}

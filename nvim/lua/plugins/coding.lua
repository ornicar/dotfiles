return {
  -- swap arguments and things
  {
    "mizlan/iswap.nvim",
    keys = {
      { "gw", ":ISwapWithRight<cr>", desc = "Swap two arguments" },
      { "<leader>is", ":ISwap<cr>", desc = "Swap many arguments" },
    },
    opts = {
      keys = "arstdhneio",
    },
  },

  -- autocompletion https://www.lazyvim.org/extras/coding/blink
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.sources.completion.enabled_providers = { "copilot", "lsp", "buffer", "path" }
      opts.keymap = {
        preset = nil,
        ["<C-h>"] = { "select_and_accept" },
        ["<C-space>"] = { "show", "accept" },
        ["<C-c>"] = { "hide" },
        ["<up>"] = { "select_prev" },
        ["<down>"] = { "select_next" },
      }
      opts.completion.accept.auto_brackets.enabled = false
      opts.completion.documentation = {
        auto_show = true,
        auto_show_delay_ms = 50,
        update_delay_ms = 50,
      }
      -- Displays a preview of the selected item on the current line
      opts.completion.ghost_text = {
        enabled = true,
      }
    end,
  },

  -- 30ms of load time for not much use
  { "rafamadriz/friendly-snippets", enabled = false },
  { "garymjr/nvim-snippets", enabled = false },

  { "echasnovski/mini.pairs", enabled = false },

  -- surround
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "<space>sa", -- Add surrounding in Normal and Visual modes
        delete = "<space>sd", -- Delete surrounding
        find = "<space>sf", -- Find surrounding (to the right)
        find_left = "<space>sF", -- Find surrounding (to the left)
        highlight = "<space>sh", -- Highlight surrounding
        replace = "<space>sr", -- Replace surrounding
        update_n_lines = "<space>sn", -- Update `n_lines`
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
        scss = { "prettierd" },
        typescript = { "prettierd" },
        markdown = { "prettierd" },
        ["markdown.mdx"] = { "prettierd" },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "nix",
        "printf",
        "python",
        "query",
        "regex",
        "rust",
        "scala",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
  },
}

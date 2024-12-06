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
      opts.sources.completion.enabled_providers = { "lsp", "path", "buffer", "copilot" }
      opts.keymap = {
        preset = nil,
        ["<C-h>"] = { "select_and_accept" },
        ["<C-space>"] = { "accept" },
        ["<C-c>"] = { "hide" },

        ["<C-e>"] = { "select_prev" },
        ["<C-n>"] = { "select_next" },

        ["<up>"] = { "scroll_documentation_up" },
        ["<down>"] = { "scroll_documentation_down" },
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

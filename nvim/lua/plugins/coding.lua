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

  {
    "nvim-treesitter/nvim-treesitter",
    ---@type TSConfig
    opts = {
      highlight = {
        disable = function(_, bufnr) -- Disable in large buffers
          return vim.api.nvim_buf_line_count(bufnr) > 10000
        end,
      },
      ensure_installed = {
        "scala",
        "haskell",
        "rust",
        "scss",
        "dart",
        "hocon",
        "bash",
        "help",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
}

return {
  -- yank ring
  {
    "gbprod/yanky.nvim",
    opts = {
      highlight = { timer = 200 },
    },
    keys = {
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
      { "<c-n>", "<Plug>(YankyCycleForward)" },
      { "<c-e>", "<Plug>(YankyCycleBackward)" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)" },
    },
  },

  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "ggandor/leap.nvim",
    keys = function()
      return {
        { "t", mode = { "n", "x" }, "<Plug>(leap-forward-to)", desc = "Leap forward to" },
        { "s", mode = { "n", "x" }, "<Plug>(leap-backward-to)", desc = "Leap backward to" },
      }
    end,
    config = function()
      local leap = require("leap")
      leap.opts.labels = { "n", "t", "e", "s", "h", "d", "l", "p", "u", "f", "i", "r", "y", "w" }
      leap.opts.safe_labels = {}
    end,
  },
  { "ggandor/flit.nvim", enabled = false },

  { "folke/todo-comments.nvim", enabled = false },

  {
    "folke/trouble.nvim",
    keys = {
      { "<space>d", "<cmd>TroubleToggle<cr>" },
    },
    opts = {
      use_diagnostic_signs = true,
      auto_open = false,
      auto_close = false,
    },
  },

  -- references
  {
    "RRethy/vim-illuminate",
    opts = { delay = 100 },
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = { on_attach = function() end },
  },

  -- git browse and blame with GitHub
  { "ruanyl/vim-gh-line" },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        desc = "Replace current word in files (Spectre)",
      },
    },
  },
}

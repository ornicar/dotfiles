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
      { "<c-p>", "<Plug>(YankyCycleBackward)" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)" },
      -- Reselect text that was just pasted
      { "<leader>v", "V`]" },
    },
  },

  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "ggandor/leap.nvim",
    dependencies = {},
    opts = {
      safe_labels = { "s", "f", "j", "u", "t", "/", "S", "F", "J", "L", "H", "M", "U", "G", "T", "?", "Z" },
    },
    config = function(_, opts) end,
  },

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
    opts = {
      delay = 100,
      large_file_cutoff = 10000,
    },
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
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open_visual({select_word=true}) end, desc = "Replace current word in files (Spectre)" },
    },
  },
}

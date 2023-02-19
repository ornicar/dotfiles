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
    },
  },

  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "ggandor/leap.nvim",
    keys = function()
      return {
        { "s", mode = { "n", "x" }, "<Plug>(leap-forward-to)", desc = "Leap forward to" },
        { "t", mode = { "n", "x" }, "<Plug>(leap-backward-to)", desc = "Leap backward to" },
        { "gs", mode = { "n", "x" }, "<Plug>(leap-from-window)", desc = "Leap from windows" },
      }
    end,
    opts = {
      safe_labels = { "s", "t", "f", "w", "b", "h", "l", "m", "k" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
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

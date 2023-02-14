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

  {
    "folke/todo-comments.nvim",
    enabled = false,
  },

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
  {
    "ruanyl/vim-gh-line",
    -- keys = {
    --   { "<leader>ghh", "<Plug>(gh-line)", desc = "Open file in GitHub" },
    -- },
    -- config = function()
    --   vim.g.gh_line_map_default = 0
    --   vim.g.gh_line_blame_map_default = 0
    -- end,
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open_visual({select_word=true}) end, desc = "Replace current word in files (Spectre)" },
    },
  },
}

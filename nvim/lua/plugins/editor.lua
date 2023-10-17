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

  -- macro tools
  {
    "ecthelionvi/NeoComposer.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    lazy = true,
    opts = {
      keymaps = {
        play_macro = false,
        yank_macro = false,
        stop_macro = false,
        toggle_record = false,
        cycle_next = false,
        cycle_prev = false,
        toggle_macro_menu = false,
      },
    },
    config = function(_, opts)
      require("NeoComposer").setup(opts)
      require("NeoComposer.store").load_macros_from_database()
    end,
    keys = {
      { "]m", "<cmd>lua require('NeoComposer.ui').cycle_next()<cr>", desc = "Macros cycle next" },
      { "[m", "<cmd>lua require('NeoComposer.ui').cycle_prev()<cr>", desc = "Macros cycle prev" },
      -- { "yq", "<cmd>lua require('NeoComposer.macro').yank_macro()<cr>", desc = "Macros yank" },
      -- { "cq", "<cmd>lua require('NeoComposer.macro').halt_macro()<cr>", desc = "Macros halt" },
      { "<c-q>", "<cmd>lua require('NeoComposer.ui').toggle_macro_menu()<cr>", desc = "Macros menu" },
      { "q", "<cmd>lua require('NeoComposer.macro').toggle_record()<cr>", desc = "Macros record" },
      {
        "Q",
        "<cmd>lua require('NeoComposer.macro').toggle_play_macro()<cr>",
        desc = "Macros play",
        mode = { "n", "x" },
      },
    },
  },

  {
    "folke/flash.nvim",
    vscode = false,
    ---@type Flash.Config
    opts = {
      labels = "nteshdlpufiryw",
      modes = {
        char = {
          enabled = false,
          label = { exclude = "rdc" },
        },
        treesitter = {
          label = { before = false, after = false },
        },
      },
    },
    keys = function()
      -- stylua: ignore
      return {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        -- { "r", mode = "o", function() requiee("flash").remote() end, desc = "Remote Flash" },
        -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    }
    end,
  },

  { "folke/todo-comments.nvim", enabled = false },

  {
    "folke/trouble.nvim",
    keys = {
      { "<space>d", "<cmd>TroubleToggle<cr>", desc = "Trouble toggle" },
      { "<space>D", "<cmd>Trouble<cr>", desc = "Trouble open" },
      {
        "<space><space>",
        function()
          local trouble = require("trouble")
          if not trouble.is_open() then
            trouble.open()
          end
          trouble.previous({ skip_groups = true, jump = false })
          trouble.next({ skip_groups = true, jump = true })
        end,
        desc = "First trouble item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            vim.cmd.cnext()
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
    opts = {
      use_diagnostic_signs = true,
      auto_open = false,
      auto_close = true,
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

  -- open file in GitHub
  {
    "almo7aya/openingh.nvim",
    lazy = true,
    keys = {
      { "<leader>gf", "<cmd>OpenInGHFile<cr>", mode = "n", desc = "Open file in GitHub" },
      { "<leader>gf", "<cmd>OpenInGHFileLines<cr>", mode = "v", desc = "Open file in GitHub" },
      { "<leader>gr", "<cmd>OpenInGHRepo<cr>", desc = "Open repo in GitHub" },
    },
  },

  {
    "gabrielpoca/replacer.nvim",
    keys = {
      { "<leader>qr", ':lua require("replacer").run()<cr>', desc = "QuickFix Replacer" },
    },
  },

  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
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

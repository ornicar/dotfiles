return {
  {
    "lambdalisue/suda.vim"
  },
  -- yank ring
  {
    "gbprod/yanky.nvim",
    enabled = true,
    opts = {
      highlight = { timer = 150 },
    },
    event = "LazyFile",
    keys = {
      -- stylua: ignore
      { "<leader>mp", function() require("telescope").extensions.yank_history.yank_history({}) end, desc = "Open Yank History", },
      {
        "y",
        "<Plug>(YankyYank)",
        mode = { "n", "x" },
        desc = "Yank Text",
      },
      {
        "p",
        "<Plug>(YankyPutAfter)",
        mode = { "n", "x" },
        desc = "Put Yanked Text After Cursor",
      },
      {
        "P",
        "<Plug>(YankyPutBefore)",
        mode = { "n", "x" },
        desc = "Put Yanked Text Before Cursor",
      },
      {
        "gp",
        "<Plug>(YankyGPutAfter)",
        mode = { "n", "x" },
        desc = "Put Yanked Text After Selection",
      },
      { "<c-]>", "<Plug>(YankyCycleForward)" },
      { "<c-[>", "<Plug>(YankyCycleBackward)" },
      {
        "]p",
        "<Plug>(YankyPutIndentAfterLinewise)",
        desc = "Put Indented After Cursor (Linewise)",
      },
      {
        "[p",
        "<Plug>(YankyPutIndentBeforeLinewise)",
        desc = "Put Indented Before Cursor (Linewise)",
      },
    },
  },

  {
    "folke/flash.nvim",
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
        { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
        { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        -- { "r", mode = "o", function() requiee("flash").remote() end, desc = "Remote Flash" },
        -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,     desc = "Toggle Flash Search" },
      }
    end,
  },

  { "folke/todo-comments.nvim", enabled = false },

  {
    "folke/trouble.nvim",
    opts = {
      auto_close = true, -- auto close when there are no items
      auto_open = true, -- auto open when there are items
      auto_preview = true, -- automatically open preview when on an item
      auto_refresh = true, -- auto refresh when open
      auto_jump = true, -- auto jump to the item when there's only one
      modes = {
        cascade = {
          mode = "diagnostics", -- inherit from diagnostics mode
          filter = function(items)
            local severity = vim.diagnostic.severity.HINT
            for _, item in ipairs(items) do
              severity = math.min(severity, item.severity)
            end
            return vim.tbl_filter(function(item)
              return item.severity == severity
            end, items)
          end,
        },
      },
    },
    keys = {
      { "<space>d", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      {
        "<space><space>",
        "<cmd>Trouble diagnostics open focus=true<cr>",
        desc = "Diagnostics (Trouble)",
      },
      -- {
      --   "]q",
      --   function()
      --     if require("trouble").is_open() then
      --       require("trouble").next({ skip_groups = true, jump = true })
      --     else
      --       vim.cmd.cnext()
      --     end
      --   end,
      --   desc = "Next trouble/quickfix item",
      -- },
    },
    opts = {
      use_diagnostic_signs = true,
      auto_open = false,
      auto_close = true,
    },
  },

  -- open file in GitHub
  {
    "almo7aya/openingh.nvim",
    lazy = true,
    keys = {
      { "<leader>gh", "<cmd>OpenInGHFile!<cr>", desc = "Open file in GitHub" },
      { "<leader>gH", "<cmd>OpenInGHFileLines!<cr>", mode = "v", desc = "Open file in GitHub" },
      { "<leader>gr", "<cmd>OpenInGHRepo<cr>", desc = "Open repo in GitHub" },
    },
  },

  {
    "gabrielpoca/replacer.nvim",
    lazy = true,
    keys = {
      { "<leader>qr", ':lua require("replacer").run()<cr>', desc = "QuickFix Replacer" },
    },
  },

  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    lazy = true,
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

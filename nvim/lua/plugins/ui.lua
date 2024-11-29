return {
  {
    "catppuccin",
    opts = {
      color_overrides = {
        mocha = {
          -- base = "1e1e2e",
          base = "#1f1e22",
          mantle = "#232224",
        },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },

  -- edgy
  {
    "folke/edgy.nvim",
    opts = {
      options = {
        left = { size = 30 },
        bottom = { size = 10 },
        right = { size = 50 },
        top = { size = 10 },
      },
      animate = {
        enabled = false,
      },
      left = {
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          pinned = true,
          open = function()
            require("neo-tree.command").execute({ dir = LazyVim.root() })
          end,
          size = { height = 0.5 },
        },
        { title = "Neotest Summary", ft = "neotest-summary" },
      },
    },
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        show_buffer_close_icons = false,
      },
    },
    keys = {
      { "<space>t", "<Cmd>BufferLinePick<CR>", desc = "Buffer picker" },
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>" },
      { "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>" },
      { "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>" },
      { "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>" },
      { "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>" },
      { "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>" },
      { "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>" },
      { "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>" },
      { "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>" },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections.lualine_a =
        { {
          "mode",
          fmt = function(str)
            return str:sub(1, 1)
          end,
        } }
      opts.sections.lualine_c[4] = { LazyVim.lualine.pretty_path({ length = 6 }) }
      -- move metals status to the left
      opts.sections.lualine_z = opts.sections.lualine_y
      opts.sections.lualine_y = opts.sections.lualine_x
      opts.sections.lualine_x = { "g:metals_status" }
      -- remove dap:
      -- table.remove(opts.sections.lualine_y, 3)
    end,
  },
  {
    "rcarriga/nvim-notify",
    keys = function()
      return {}
    end,
  },
  {
    "sethen/line-number-change-mode.nvim",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })
      local palette = require("catppuccin.palettes").get_palette("mocha")

      if palette == nil then
        return nil
      end

      require("line-number-change-mode").setup({
        mode = {
          i = {
            bg = palette.green,
            fg = palette.mantle,
            bold = true,
          },
          n = {
            bg = palette.blue,
            fg = palette.mantle,
            bold = true,
          },
          R = {
            bg = palette.maroon,
            fg = palette.mantle,
            bold = true,
          },
          v = {
            bg = palette.mauve,
            fg = palette.mantle,
            bold = true,
          },
          V = {
            bg = palette.mauve,
            fg = palette.mantle,
            bold = true,
          },
        },
      })
    end,
  },

  -- dashboard
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          keys = {
            {
              icon = "󰘬 ",
              key = "g",
              desc = "LazyGit",
              action = function()
                Snacks.lazygit({ cwd = LazyVim.root.git(), size = { width = 1, height = 1 } })
              end,
            },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = [[
        =================     ===============     ===============   ========  ========
        \\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //
        ||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||
        || . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||
        ||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||
        || . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||
        ||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||
        || . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||
        ||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||
        ||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||
        ||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||
        ||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||
        ||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||
        ||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||
        ||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||
        ||.=='    _-'                                                     `' |  /==.||
        =='    _-'                        N E O V I M                         \/   `==
        \   _-'                                                                `-_   /
         `''                                                                      ``'
 ]],
        },
      },
    },
  },
}

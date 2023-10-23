return {
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
      table.remove(opts.sections.lualine_c, 2) -- remove filetype icon
      opts.sections.lualine_c[2].path = 3 -- add project name
      -- move metals status to the left
      opts.sections.lualine_z = opts.sections.lualine_y
      opts.sections.lualine_y = opts.sections.lualine_x
      opts.sections.lualine_x = { "g:metals_status" }
      table.remove(opts.sections.lualine_y, 3)
    end,
  },
  {
    "rcarriga/nvim-notify",
    keys = function()
      return {}
    end,
  },

  -- dashboard
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      local logo = [[
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
]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },

  -- just 4 fun
  {
    "eandrju/cellular-automaton.nvim",
    keys = {
      {
        "<leader>cer",
        "<cmd>CellularAutomaton make_it_rain<cr>",
        desc = "Automaton: Make it rain",
      },
      {
        "<leader>cel",
        "<cmd>CellularAutomaton game_of_life<cr>",
        desc = "Automaton: Game of life",
      },
      {
        "<leader>ces",
        "<cmd>CellularAutomaton scramble<cr>",
        desc = "Automaton: Scramble",
      },
    },
  },

  {
    "giusgad/pets.nvim",
    -- branch = "forbidden-cats",
    dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
    -- opts = {
    --   default_style = "red",
    -- },
    keys = {
      { "<leader>cec", "<cmd>PetsNew clippy<cr>", desc = "Spawn clippy" },
      { "<leader>ced", "<cmd>PetsNew dog<cr>", desc = "Spawn a dog" },
      { "<leader>cek", "<cmd>PetsKillAll<cr>", desc = "Kill the pets" },
    },
  },
}

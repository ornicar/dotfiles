return {
  -- just 4 fun
  {
    "eandrju/cellular-automaton.nvim",
    enabled = true,
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
    "nvchad/showkeys",
    cmd = "ShowkeysToggle",
    keys = {
      { "<leader>uk", "<cmd>ShowkeysToggle<cr>", desc = "Show keys" },
    },
    opts = {
      timeout = 2,
      maxkeys = 7,
      position = "top-right",
      show_count = true,
    },
  },
  -- { "nvzone/timerly", cmd = "TimerlyToggle", dependencies = { "nvzone/volt" } },
  -- {
  --   "jackplus-xyz/player-one.nvim",
  --   ---@type PlayerOne.Config
  --   opts = {
  --     -- your configuration comes here
  --     -- or leave it empty to use the default settings
  --     -- refer to the configuration section below
  --   },
  -- },
}

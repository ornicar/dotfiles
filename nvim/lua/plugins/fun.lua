return {
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
}

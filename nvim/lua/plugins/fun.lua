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

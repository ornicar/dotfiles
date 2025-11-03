return {
  {
    "jrop/mongo.nvim",
    lazy = true,
    keys = {
      { "<leader>om", "<cmd>Mongoconnect lichess<cr>", desc = "MongoDB connect" },
      { "<leader>omc", "<cmd>Mongocollections<cr>", desc = "MongoDB collections" },
      { "<leader>omq", "<cmd>Mongoquery<cr>", desc = "MongoDB collections" },
    },
  },
}

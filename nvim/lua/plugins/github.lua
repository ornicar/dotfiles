return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>gi",
        function()
          Snacks.picker.gh_issue()
        end,
        desc = "GitHub Issues (open)",
      },
      {
        "<leader>gI",
        function()
          Snacks.picker.gh_issue({ state = "all" })
        end,
        desc = "GitHub Issues (all)",
      },
      {
        "<leader>gp",
        function()
          Snacks.picker.gh_pr()
        end,
        desc = "GitHub Pull Requests (open)",
      },
      {
        "<leader>gP",
        function()
          Snacks.picker.gh_pr({ state = "all" })
        end,
        desc = "GitHub Pull Requests (all)",
      },
    },
  },

  {
    "almo7aya/openingh.nvim",
    lazy = true,
    keys = {
      { "<leader>gH", "<cmd>OpenInGHFileLines!<cr>", mode = "v", desc = "Open file in GitHub" },
    },
  },
}

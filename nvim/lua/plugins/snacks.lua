local large = {
  width = 0.95,
  height = 0.9,
}
return {
  {
    "folke/snacks.nvim",
    opts = {
      styles = {
        lazygit = large,
        blame_line = large,
        notification_history = large,
      },
      picker = {
        sources = {
          explorer = {},
        },
      },
      image = {},
      lazygit = {
        configure = true,
        config = {
          os = { editPreset = "nvim-remote" },
        },
      },
    },
    keys = {
      {
        "<space>e",
        function()
          Snacks.explorer.open({ cwd = LazyVim.root() })
        end,
        desc = "Explorer Snacks (root dir)",
      },
      {
        "<space>E",
        function()
          Snacks.explorer()
        end,
        desc = "Explorer Snacks (cwd)",
      },
    },
  },
}

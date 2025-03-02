local large = {
  width = 0.9,
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
      explorer = {},
      image = {},
    },
    keys = {
      {
        "<space>e",
        function()
          Snacks.explorer({ cwd = LazyVim.root() })
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

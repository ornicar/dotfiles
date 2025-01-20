local large = {
  width = 0.97,
  height = 0.95,
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
    },
  },
}

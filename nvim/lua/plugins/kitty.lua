return {
  "mikesmithgh/kitty-scrollback.nvim",
  enabled = true,
  lazy = true,
  cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
  event = { "User KittyScrollbackLaunch" },
  version = "*", -- latest stable version, may have breaking changes if major version changed
  config = function()
    require("kitty-scrollback").setup()
  end,
}

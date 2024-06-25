return {
  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    version = "*", -- latest stable version, may have breaking changes if major version changed
    config = function()
      require("kitty-scrollback").setup()
    end,
  },
  {
    "glacambre/firenvim",
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
    config = function()
      vim.g.firenvim_config = {
        -- config values, like in my case:
        localSettings = {
          [".*"] = {
            takeover = "never",
            -- selector = 'textarea:not([readonly], [aria-readonly]), div[role="textbox"]'
            selector = "textarea:not([readonly], [aria-readonly])",
            cmdline = "firenvim",
          },
          ["https://google.com/"] = { takeover = "never", priority = 1 },
        },
      }
    end,
  },
  { "noice.nvim", cond = not vim.g.started_by_firenvim },
  { "lualine.nvim", cond = not vim.g.started_by_firenvim },
  -- {
  --   "folke/noice.nvim",
  --   enabled = not vim.g.started_by_firenvim,
  -- },
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local theme = "catppuccin-mocha"

require("lazy").setup({
  spec = {
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = theme,
        defaults = {
          autocmds = true, -- lazyvim.config.autocmds
          keymaps = false, -- lazyvim.config.keymaps
          options = true, -- lazyvim.config.options
        },
      },
      import = "lazyvim.plugins",
    },
    -- import/override with your plugins
    { import = "plugins" },
  },
  install = { colorscheme = { theme } },
  defaults = {
    lazy = false,
    version = false,
  },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.opt.mouse = "" -- Disable mouse mode
vim.opt.relativenumber = false -- Relative line numbers
vim.opt.scrolloff = 9 -- Lines of context

vim.opt.backup = false -- Don't store backup while overwriting the file
vim.opt.writebackup = false -- Don't store backup while overwriting the file
vim.opt.swapfile = false -- Use an SCM instead of swap files

vim.opt.virtualedit = "block" -- Allow going past the end of line in visual block mode

-- for edgy: Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = "screen"

vim.g.deprecation_warnings = true
vim.g.snacks_animate = false

if vim.g.neovide then
  -- https://neovide.dev/configuration.html
  vim.g.neovide_floating_corner_radius = 0.7
  vim.g.neovide_normal_opacity = 0.95
  vim.o.guifont = "JetBrains Mono:h15.5"
  vim.g.neovide_position_animation_length = 0.15
  vim.g.neovide_scroll_animation_length = 0.2
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.2
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_unfocused_outline_width = 0.125
  vim.g.neovide_cursor_vfx_mode = "sonicboom"
end

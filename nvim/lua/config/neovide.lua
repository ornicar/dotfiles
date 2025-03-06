-- https://neovide.dev/configuration.html
vim.g.neovide_floating_corner_radius = 0.7
vim.g.neovide_normal_opacity = 0.95
vim.o.guifont = "JetBrains Mono:h15.5"
vim.g.neovide_position_animation_length = 0.15
vim.g.neovide_scroll_animation_length = 0.15
vim.g.neovide_cursor_animation_length = 0.07
vim.g.neovide_cursor_trail_size = 0.3
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_unfocused_outline_width = 0.125
vim.g.neovide_cursor_vfx_mode = "sonicboom"

-- https://github.com/neovide/neovide/issues/1282#issuecomment-2496204257
vim.api.nvim_set_keymap("t", "<sc-v>", '<C-\\><C-n>"+Pi', { noremap = true })

-- vim.opt.guicursor = {
--   "n-v-c-sm:block-Cursor", -- Use 'Cursor' highlight for normal, visual, and command modes
--   "i-ci-ve:ver25-lCursor", -- Use 'lCursor' highlight for insert and visual-exclusive modes
--   "r-cr:hor20-CursorIM", -- Use 'CursorIM' for replace mode
-- }
-- ugh. stylix save me
-- https://github.com/neovide/neovide/issues/2050#issuecomment-2571258610
vim.g.terminal_color_0 = "#45475a"
vim.g.terminal_color_1 = "#f38ba8"
vim.g.terminal_color_2 = "#a6e3a1"
vim.g.terminal_color_3 = "#f9e2af"
vim.g.terminal_color_4 = "#89b4fa"
vim.g.terminal_color_5 = "#f5c2e7"
vim.g.terminal_color_6 = "#94e2d5"
vim.g.terminal_color_7 = "#bac2de"
vim.g.terminal_color_8 = "#585b70"
vim.g.terminal_color_9 = "#f38ba8"
vim.g.terminal_color_10 = "#a6e3a1"
vim.g.terminal_color_11 = "#f9e2af"
vim.g.terminal_color_12 = "#89b4fa"
vim.g.terminal_color_13 = "#f5c2e7"
vim.g.terminal_color_14 = "#94e2d5"
vim.g.terminal_color_15 = "#a6adc8"

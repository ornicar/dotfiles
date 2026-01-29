-- https://neovide.dev/configuration.html
vim.g.neovide_floating_corner_radius = 0.7
vim.g.neovide_normal_opacity = 0.85
-- vim.o.guifont = "JetBrains Mono:h15.5"

-- vim.g.neovide_position_animation_length = 0.15

vim.g.neovide_scroll_animation_length = 0
vim.g.neovide_scroll_animation_far_lines = 5

vim.g.neovide_cursor_animation_length = 0.15
vim.g.neovide_cursor_trail_size = 0.9
-- typing animation
vim.g.neovide_cursor_short_animation_length = 0.25

vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_unfocused_outline_width = 0.125

-- vim.g.neovide_cursor_vfx_mode = "sonicboom"
-- vim.g.neovide_cursor_vfx_mode = { "railgun", "pixiedust", "sonicboom" }
vim.g.neovide_cursor_vfx_mode = { "railgun", "pixiedust" }
-- vim.g.neovide_cursor_vfx_particle_highlight_lifetime = 0.1 -- sonicboom
vim.g.neovide_cursor_vfx_particle_lifetime = 0.7 -- railgun

-- https://github.com/neovide/neovide/issues/1282#issuecomment-2496204257
vim.api.nvim_set_keymap("t", "<sc-v>", '<C-\\><C-n>"+Pi', { noremap = true })

-- vim.opt.guicursor = {
--   "n-v-c-sm:block-Cursor", -- Use 'Cursor' highlight for normal, visual, and command modes
--   "i-ci-ve:ver25-lCursor", -- Use 'lCursor' highlight for insert and visual-exclusive modes
--   "r-cr:hor20-CursorIM", -- Use 'CursorIM' for replace mode
-- }

local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
end
vim.keymap.set({ "n" }, "<C-ScrollWheelUp>", function()
  change_scale_factor(0.05)
end)
vim.keymap.set({ "n" }, "<C-ScrollWheelDown>", function()
  change_scale_factor(-0.05)
end)

local function paste()
  vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
end
vim.keymap.set({ "v", "c", "t" }, "<C-v>", paste, { silent = true, desc = "Paste" })

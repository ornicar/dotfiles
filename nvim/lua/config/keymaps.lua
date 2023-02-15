-- Keymaps are automatically loaded on the VeryLazy event                                                                   █
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua         █
-- Add any additional keymaps here

require("config.keymaps_colemak")
require("config.keymaps_lazyvim")
require("config.unimpaired")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "!", ":!")

map("n", "<leader>wo", ":only<cr>", { desc = "Close other windows" })

-- delete buffer
map("n", "<leader>wd", ":bd<cr>")
-- delete buffer and file
map("n", "<leader>wD", ":!rm %<cr>:bd!<cr>")

-- Copy current file path to registers "* and "+
map("n", "<leader>cp", ":let @*=@%<cr>:let @+=@%<cr>")

-- Yank from the cursor to the end of the line, to be consistent with C and D.
map("n", "Y", "y$")

-- Start a substitute
map("n", "<leader>ss", ":%s/\v")

-- Pull word under cursor into LHS of a substitute (for quick search and replace)
map("n", "<leader>zs", ':%s#<C-r>=expand("<cword>")<cr>#')

-- wordwise yank from line above
vim.cmd([[
inoremap <silent> <C-Y> <C-C>:let @z = @"<cr>mz
      \:exec 'normal!' (col('.')==1 && col('$')==1 ? 'k' : 'kl')<cr>
      \:exec (col('.')==col('$')-1 ? 'let @" = @_' : 'normal! yw')<cr>
      \`zp:let @" = @z<cr>a
]])

-- Make the current file executable
map("n", "<leader>%", ":!chmod +x %<cr>")

-- Expand current filed dir in console mode
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>")

-- Jump to line AND col
map("n", "'", "`")

-- trouble navigation
map("n", "[c", function()
  require("trouble").previous({ skip_groups = true, jump = true })
end, { desc = "Next trouble entry" })
map("n", "]c", function()
  require("trouble").next({ skip_groups = true, jump = true })
end, { desc = "Prev trouble entry" })

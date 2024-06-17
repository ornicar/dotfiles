-- This file replaces LazyVim/lua/lazyvim/config/keymaps.lua
local Util = require("lazyvim.util")

local map = Util.safe_keymap_set

-- Move in windows using <ctrl> arrow keys
map("n", "<leader>n", "<C-w>h", { desc = "Go to left window" })
map("n", "<leader>e", "<C-w>l", { desc = "Go to right window" })
map("n", "<leader>l", "<C-w>k", { desc = "Go to upper window" })
map("n", "<leader>h", "<C-w>j", { desc = "Go to lower window" })
-- Resize window using <ctrl><shift> arrow keys
-- map("n", "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- map("n", "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- map("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
-- map("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
-- map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
-- map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
-- map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
-- map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<leader>md", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>wd", LazyVim.ui.bufremove, { desc = "Delete Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "j", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "j", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "j", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "J", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "J", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "J", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Alternative way to save and exit in Normal mode.
-- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
map("n", "<C-s>", "<Cmd>silent! update | redraw<CR>", { desc = "Save" })
map({ "i", "x" }, "<C-s>", "<Esc><Cmd>silent! update | redraw<CR>", { desc = "Save and go to Normal mode" })

-- better indenting
map("v", "<", "<gv", { desc = "Indent right" })
map("v", ">", ">gv", { desc = "Indent left" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- formatting
map({ "n", "v" }, "<leader>cf", function()
  Util.format({ force = true })
end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- stylua: ignore start

-- toggle options
map("n", "<leader>uf", function() Util.format.toggle() end, { desc = "Toggle auto format (global)" })
map("n", "<leader>uF", function() Util.format.toggle(true) end, { desc = "Toggle auto format (buffer)" })
map("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function() Util.toggle.number() end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", Util.toggle.diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() Util.toggle("conceallevel", false, { 0, conceallevel }) end,
  { desc = "Toggle Conceal" })
map("n", "<leader>ug", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Git blame" })
if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
  map("n", "<leader>uh", function() Util.toggle.inlay_hints() end, { desc = "Toggle Inlay Hints" })
end

-- lazygit
local full_size = { width = 1, height = 1 }
map("n", "<leader>gg", function() LazyVim.lazygit( { cwd = LazyVim.root.git(), size = full_size }) end, { desc = "Lazygit (Root Dir)" })
map("n", "<leader>gf", function()
  local git_path = vim.api.nvim_buf_get_name(0)
  LazyVim.lazygit({args = { "-f", vim.trim(git_path) }})
end, { desc = "Lazygit Current File History" })
map("n", "<leader>gb", LazyVim.lazygit.blame_line, { desc = "Git Blame Line" })
map("n", "<leader>gl", function()
  LazyVim.lazygit({ args = { "log" }, cwd = LazyVim.root.git() })
end, { desc = "Lazygit Log" })
map("n", "<leader>gB", LazyVim.lazygit.browse, { desc = "Git Browse" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- floating terminal
map("n", "<leader>ft", function() Util.terminal(nil, { cwd = Util.root.get(), }) end, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function() Util.terminal() end, { desc = "Terminal (cwd)" })
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<c-t>", "<c-\\><c-n><c-w>k", { desc = "Switch away from the terminal to top window." })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

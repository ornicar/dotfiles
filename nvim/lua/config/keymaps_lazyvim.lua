-- This file replaces LazyVim/lua/lazyvim/config/keymaps.lua
local map = LazyVim.safe_keymap_set

-- Move in windows using <ctrl> arrow keys
map("n", "<C-Left>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-Down>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-Up>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-Right>", "<C-w>l", { desc = "Go to right window" })
-- Resize window using <ctrl><shift> arrow keys
map("n", "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

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

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

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
  LazyVim.format({ force = true })
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
map("n", "<leader>uf", function() LazyVim.format.toggle() end, { desc = "Toggle auto format (global)" })
map("n", "<leader>uF", function() LazyVim.format.toggle(true) end, { desc = "Toggle auto format (buffer)" })
map("n", "<leader>us", function() LazyVim.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() LazyVim.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function() LazyVim.toggle.number() end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", LazyVim.toggle.diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() LazyVim.toggle("conceallevel", false, { 0, conceallevel }) end,
  { desc = "Toggle Conceal" })
map("n", "<leader>ug", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Git blame" })
if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
  map("n", "<leader>uh", function() LazyVim.toggle.inlay_hints() end, { desc = "Toggle Inlay Hints" })
end

-- lazygit
local lg_full_size = { width = 1, height = 1 }
map("n", "<leader>gg",
  function() LazyVim.lazygit({ esc_esc = false, ctrl_hjkl = false, size = lg_full_size, cwd = LazyVim.root.git() }) end,
  { desc = "Lazygit (Root Dir)" })
map("n", "<leader>gG", function() LazyVim.lazygit({ esc_esc = false, ctrl_hjkl = false, size = lg_full_size }) end,
  { desc = "Lazygit (cwd)" })
map("n", "<leader>gf", function()
  local git_path = vim.api.nvim_buf_get_name(0)
  LazyVim.terminal({ "lazygit", "-f", vim.trim(git_path) }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit current file history" })
map("n", "<leader>gb", LazyVim.lazygit.blame_line, { desc = "Git Blame Line" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- floating terminal
map("n", "<leader>ft", function() LazyVim.terminal(nil, { cwd = LazyVim.root.get() }) end,
  { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function() LazyVim.terminal() end, { desc = "Terminal (cwd)" })
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
-- map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

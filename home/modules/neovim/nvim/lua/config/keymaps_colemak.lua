local map = vim.keymap.set

-- next -> down
map("", "n", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Faster viewport scrolling
map("", "N", "v:count == 0 ? '3gj' : '3j'", { expr = true, silent = true })
-- down -> next
map("n", "j", "n")
-- join lines -> previous
map("n", "J", "N")
-- new mapping for join
map("n", "<leader>j", "J")

-- end -> up
map("", "e", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- Faster viewport scrolling
map("", "E", "v:count == 0 ? '3gk' : '3k'", { expr = true, silent = true })
-- up -> end
map("n", "k", "e")
map("v", "k", "e")
-- program -> end inclusive
map("n", "K", "E")

map("", "H", "^")
map("", "L", "$")

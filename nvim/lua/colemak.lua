local map = vim.keymap.set

-- next -> down
map('n', 'j')
-- Faster viewport scrolling
map('N', '3j')
-- down -> next
map('j', 'n')
-- join lines -> previous
map('J', 'N')
-- new mapping for join
map('<leader>j', 'J')

-- end -> up
map('e', 'k')
-- Faster viewport scrolling
map('E', '3k')
-- up -> end
map('k', 'e')
-- program -> end inclusive
map('K', 'E')

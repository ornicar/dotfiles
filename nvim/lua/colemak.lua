local map = vim.keymap.set

-- next -> down
map('', 'n', 'j')
-- Faster viewport scrolling
map('', 'N', '3j')
-- down -> next
map('n', 'j', 'n')
-- join lines -> previous
map('n', 'J', 'N')
-- new mapping for join
map('n', '<leader>j', 'J')

-- end -> up
map('', 'e', 'k')
-- Faster viewport scrolling
map('', 'E', '3k')
-- up -> end
map('n', 'k', 'e')
map('v', 'k', 'e')
-- program -> end inclusive
map('n', 'K', 'E')

map('', 'H', '^')
map('', 'L', '$')

function map(mode, shortcut, command, opts)
  vim.api.nvim_set_keymap(mode, shortcut, command, opts or {})
end

-- Colemak

-- next -> down
map('n', 'n', 'j', { noremap = true })
-- Faster viewport scrolling
map('n', 'N', '3j', { noremap = true })
-- down -> next
map('n', 'j', 'n', { noremap = true })
-- join lines -> previous
map('n', 'J', 'N', { noremap = true })
-- new mapping for join
map('n', '<leader>j', 'J', { noremap = true })

-- end -> up
map('n', 'e', 'k', { noremap = true })
-- Faster viewport scrolling
map('n', 'E', '3k', { noremap = true })
-- up -> end
map('n', 'k', 'e', { noremap = true })
-- program -> end inclusive
map('n', 'K', 'E', { noremap = true })

-- Colemak end

map('n', '<leader>sm', ':source $MYVIMRC<cr>')

map('n', 'H', '^', { noremap = true })
map('n', 'L', '$', { noremap = true })
map('n', '!', ':!')

-- Toggle nowrap
map('n', '<leader>nw', ':set nowrap!<cr>', { silent = true, noremap = true })

-- Close other windows
map('n', '<leader>wo', ':only<cr>')

-- Move in windows
map('n', '<leader>ww', ':wincmd w<cr>')
map('n', '<leader>wh', ':wincmd h<cr>')
map('n', '<leader>wj', ':wincmd j<cr>')
map('n', '<leader>wk', ':wincmd k<cr>')
map('n', '<leader>wl', ':wincmd l<cr>')

-- Previous buffer
map('n', '<leader>md', ':b#<cr>')
-- delete buffer
map('n', '<leader>wd', ':bd<cr>')
-- delete buffer and file
map('n', '<leader>wD', ':!rm %<cr>:bd!<cr>')

-- Copy current file path to registers "* and "+
map('n', '<leader>cp', ':let @*=@%<cr>:let @+=@%<cr>')

-- Yank from the cursor to the end of the line, to be consistent with C and D.
map('n', 'Y', 'y$', { noremap = true })

-- Use space as " shortcut
map('n', '<space>', '"')
map('v', '<space>', '"')

-- Swap two words
-- map('n', 'gw', ":s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'", { silent = true })
-- map('n', 'gW', ":s/\(\%#[^\s]\+\)\(\_W\+\)\([^\s]\+\)/\3\2\1/<CR>`'", { silent = true })

-- Clear search highlight
map('n', '<leader>/', ':nohl<cr>', { silent = true })

-- Start a substitute
map('n', '<leader>ss', ':%s/\v')

-- Pull word under cursor into LHS of a substitute (for quick search and replace)
map('n', '<leader>zs', ':%s#<C-r>=expand("<cword>")<cr>#')

-- Use perl regex style
map('n', '/', '/\v', { noremap = true })
map('v', '/', '/\v', { noremap = true })
map('n', '?', '?\v', { noremap = true })
map('v', '?', '?\v', { noremap = true })

-- Search to quickfix
map('n', '<leader>rg', ':Rg<space>')

-- Open omnicomplete with tab
map('i', '<Tab>', '<C-x><C-o>', { noremap = true })

-- Fast save (also clears the search)
map('n', '<C-e>', ':nohl<cr>:w<cr>')
map('i', '<C-e>', ':nohl<cr>:w<cr>')
map('i', '<C-e>', '<esc>:nohl<cr>:w<cr>')
map('n', '<C-S-E>', ':nohl<cr>:noa w<cr>')
map('i', '<C-S-E>', ':nohl<cr>:noa w<cr>')
map('i', '<C-S-E>', '<esc>:nohl<cr>:noa w<cr>')

-- Previous element during omnicomplete (<C-e> is used for fast save)
map('i', '<expr>', [[pumvisible() ? "\<C-p>" : "\<C-k>"]], { expr = true })

-- Reselect text that was just pasted with ,v
map('n', '<leader>v', 'V`]', { noremap = true })

-- wordwise yank from line above
-- imap('<C-Y>', '<C-C>:let @z = @"<cr>mz
--       \:exec 'normal!' (col('.')==1 && col('$')==1 ? 'k' : 'kl')<cr>
--       \:exec (col('.')==col('$')-1 ? 'let @" = @_' : 'normal! yw')<cr>
--       \`zp:let @" = @z<cr>a\', { noremap = true, silent = true })

-- Don't use Ex mode; use Q for console mode
map('n', 'Q', 'q:')

-- Fast file renaming
-- nmap R :let _pfn="<C-R>=expand("%:t")<cr>"<cr>rename <C-R>=expand(_pfn)<cr><esc>^w

-- Make the current file executable
map('n', '<leader>%', ':!chmod +x %<cr>')

-- Expand current filed dir in console mode
map('c', '%%', "<C-R>=expand('%:h').'/'<cr>", { noremap = true })

-- Jump to line AND col
map('n', "'", '`', { noremap = true })

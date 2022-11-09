-- Inspired by https://github.com/tpope/vim-unimpaired

-- function! s:BlankUp() abort
--   put!=repeat(nr2char(10), 1)
-- endfunction

-- function! s:BlankDown() abort
--   put =repeat(nr2char(10), 1)
-- endfunction

-- nmap [<space> :<C-U>call <SID>BlankUp()<CR>
-- nmap ]<space> :<C-U>call <SID>BlankDown()<CR>

vim.keymap.set('n', '[q', ':<C-U>:cprev<CR>')
vim.keymap.set('n', ']q', ':<C-U>:cnext<CR>')

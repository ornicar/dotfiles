-- vim.cmd([[
-- setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/**,mb:*,ex:*/,s1:/*,mb:*,ex:*/,://
-- setlocal commentstring=//\ %s
-- setlocal shiftwidth=2 softtabstop=2 expandtab
-- setlocal path+=src/main/scala,src/test/scala,src/main,src/test
-- setlocal suffixesadd=.scala
-- setlocal formatoptions-=t formatoptions+=croqnlj
-- setlocal include='^\s*import'
-- setlocal includeexpr='substitute(v:fname,"\\.","/","g")'
-- ]])

-- Operator notation: transforms a.b(c) to a b c
vim.keymap.set('n', '<leader>s.', 'f.r<space>f(sd(i <esc>', {buffer=true})

-- Triple quotes: transforms "abc" to """abc"""
vim.keymap.set('n', '<leader>s', 'ysi""lysi""', {buffer=true})

vim.keymap.set('n', '<leader>i', '<Esc>:SortScalaImports<cr>:w<cr>', {buffer=true})

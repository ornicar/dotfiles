-- let g:fzf_preview_window = 'right:60%'
-- let g:fzf_tags_command = 'ctags --recurse --options=.ctags'

require'fzf-lua'.setup {
  winopts = {
    fullscreen       = true,           -- start fullscreen?
    preview = {
      -- default     = 'bat',           -- override the default previewer?
      horizontal     = 'right:65%'     -- right|left:size
    }
  }
}

map('n', '<leader>ms', "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
map('n', '<leader>mb', "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
map('n', '<leader>mr', ":FzfLua files cwd=<C-R>=expand('%:h')<CR><CR>", { silent = true })
map('n', '<leader>a', "<cmd>lua require('fzf-lua').live_grep_native()<CR>", { silent = true })
map('n', '<leader>za', "mA:FzfLua grep_cword<CR>", { silent = true })
map('n', '<leader>zr', "mA:Rg <C-R>=expand('<cword>')<CR><CR>", { silent = true })

map('n', '<leader>H', ':FzfLua help_tags<cr>')

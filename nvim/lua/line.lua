require('lualine').setup {
  sections = { 
    lualine_a = { { 'mode', fmt = function(str) return str:sub(1,1) end } },
    lualine_x = {'g:metals_status', 'filetype'}
  }
}

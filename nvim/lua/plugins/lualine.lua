require('lualine').setup {
  sections = {
    lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 1) end } },
    lualine_b = { 'branch', 'diff',
      { 'diagnostics', sources = { 'nvim_diagnostic', 'nvim_lsp' } }
    },
    lualine_c = {
      { 'filename', path = 3 },
      -- 'buffers'
    },
    lualine_x = { 'g:metals_status' }
  }
}

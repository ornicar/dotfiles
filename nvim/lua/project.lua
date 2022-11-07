-- Project-specific settings

vim.cmd([[
  augroup ProjectSetup
    au BufRead,BufEnter /home/thib/lila/* let g:scala_first_party_namespaces='lila'
    au BufRead,BufEnter /home/thib/scalachess/* let g:scala_first_party_namespaces='chess'
  augroup END
]])

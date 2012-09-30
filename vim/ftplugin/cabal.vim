" Compile and open quickfix window
" compiler cabal
setlocal makeprg=cabal\ build
nmap <silent> <buffer> <leader>mm :make<cr>:cwindow<cr>
nmap <silent> <buffer> <leader>mc :!cabal configure<cr>,mm
setlocal errorformat=
      \%-Z\ %#,
      \%W%f:%s:%c:\ Warning:\ %m,
      \%E%f:%s:%c:\ %m,
      \%E%f:%l:%c:,
      \%E%>%f:%s:%c:,
      \%+C\ \ %#%m,
      \%W%>%f:%s:%c:,
      \%+C\ \ %#%tarning:\ %m,
      \cabal:\ %m,
      \%-G%.%#

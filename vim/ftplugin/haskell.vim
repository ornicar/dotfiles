" hoogle
nmap <buffer> <leader>ho :Hoogle<space>
nmap <buffer> <leader>hc :HoogleClose<cr>:GhcModTypeClear<cr>
nmap <buffer> <leader>hh :Hoogle "<C-r>=expand("<cword>")<cr>"<cr>

" ghc-mod
au BufWritePost *.hs GhcModCheckAndLintAsync
let g:ghcmod_ghc_options = ['-fno-warn-type-defaults']
nmap <buffer> <leader>ht :GhcModType<cr>
nmap <buffer> <leader>hp V:PointFree<cr>
vmap <buffer> <leader>hp :PointFree<cr>

" Fast save (also clears the search, hoogle, and completion)
noremap <buffer> <C-u> :nohl<cr>:HoogleClose<cr>:GhcModTypeClear<cr>:w<cr>
inoremap <buffer> <C-u> <esc>:nohl<cr>:HoogleClose<cr>:GhcModTypeClear<cr>:w<cr>

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

" Format with haskell-tidy then save
nmap <buffer> <leader>i :nohl<cr>my:%!stylish-haskell<cr>'y:w<cr>

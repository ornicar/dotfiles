" hoogle
nmap <buffer> <leader>ho :Hoogle
nmap <buffer> <leader>hc :HoogleClose<cr>:GhcModTypeClear<cr>
nmap <buffer> <leader>hh :Hoogle "<C-r>=expand("<cword>")<cr>"<cr>

" ghc-mod
au BufWritePost *.hs GhcModCheckAndLintAsync
nmap <buffer> <leader>ht :GhcModType<cr>
let g:ghcmod_ghc_options = ['-fno-warn-type-defaults']
"
" Fast save (also clears the search, hoogle, and completion)
noremap <buffer> <C-u> :nohl<cr>:HoogleClose<cr>:GhcModTypeClear<cr>:w<cr>
inoremap <buffer> <C-u> <esc>:nohl<cr>:HoogleClose<cr>:GhcModTypeClear<cr>:w<cr>

" Compile and open quickfix window
" compiler cabal
setlocal makeprg=cabal\ build
nmap <silent> <buffer> <leader>mm :make<cr>:copen<cr>
nmap <silent> <buffer> <leader>mc :!cabal configure<cr>,mm

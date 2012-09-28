compiler cabal

" hoogle
nmap <buffer> <leader>ho :Hoogle 
nmap <buffer> <leader>hc :HoogleClose<cr>:GhcModTypeClear<cr>
nmap <buffer> <leader>hh :Hoogle "<C-r>=expand("<cword>")<cr>"<cr>

" ghc-mod
au BufWritePost *.hs GhcModCheckAndLintAsync
nmap <buffer> <leader>ht :GhcModType<cr>
let g:ghcmod_ghc_options = ['-fno-warn-type-defaults']

" vim2hs
let s:haskell_conceal = 1
let s:haskell_conceal_wide = 1
let s:haskell_conceal_enumerations = 1
" let s:haskell_conceal_comments = 1
let s:haskell_conceal_bad = 1
"
" Fast save (also clears the search, hoogle, and completion)
noremap <buffer> <C-u> :nohl<cr>:HoogleClose<cr>:GhcModTypeClear<cr>:w<cr>
inoremap <buffer> <C-u> <esc>:nohl<cr>:HoogleClose<cr>:GhcModTypeClear<cr>:w<cr>

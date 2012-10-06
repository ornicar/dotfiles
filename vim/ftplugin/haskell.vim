" hoogle
nmap <buffer> <leader>ho :Hoogle<space>
nmap <buffer> <leader>hh :Hoogle "<C-r>=expand("<cword>")<cr>"<cr>

" ghc-mod
au BufWritePost *.hs GhcModCheckAndLintAsync
let g:ghcmod_ghc_options = ['-fno-warn-type-defaults', '-fno-warn-missing-signatures', '-fno-warn-unused-binds', '-fno-warn-unused-matches']
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
nmap <silent> <buffer> <leader>mc :!cabal configure --enable-tests<cr>,mm
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

" From http://projects.haskell.org/haskellmode-vim
setlocal include=^import\\s*\\(qualified\\)\\?\\s*
setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.'
setlocal suffixesadd=hs,lhs,hsc

" Mappings for ftplugin/haskell_doc.vim
map <leader>h? :call Haddock()<cr>
map <leader>h. :call Qualify()<cr>
map <leader>hi :call Import(1,0)<cr>
"
" Enable folding by default
set foldenable

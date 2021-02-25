" === Plug Tig ===

nmap ti :Tig<cr>

" === Plug autoformat ===

" use scalafmt to format scala
let g:formatdef_scalafmt = '"scalafmt --stdin"'
let g:formatters_scala = ['scalafmt']
" don't default to vim format when formatter fails (because syntax error)
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0

" === Plug commentary ===

nmap <leader>c<space> <Plug>CommentaryLine
vmap <leader>c<space> <Plug>Commentary

" === Plug BufStop ===

let g:BufstopKeys = "arstneio"

nmap <leader>mt :BufstopMode<CR>

" === Plug vinegar ===

let g:netrw_liststyle=3

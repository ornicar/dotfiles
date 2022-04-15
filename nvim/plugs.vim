" === Plug autoformat ===

" use scalafmt to format scala
let g:formatdef_scalafmt = '"scalafmt --stdin"'
let g:formatters_scala = ['scalafmt']
" don't default to vim format when formatter fails (because syntax error)
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0

" === Plug rust ===

let g:rustfmt_autosave = 0 " coc does it

" === Plug commentary ===

nmap <leader>c<space> <Plug>CommentaryLine
vmap <leader>c<space> <Plug>Commentary

" === Plug BufStop ===

let g:BufstopKeys = "arstneio"

nmap <leader>mt :BufstopMode<CR>

" === Plug vinegar ===

let g:netrw_liststyle=3

" === lazygit ===

nnoremap <silent> <leader>gg :LazyGit<cr>

let g:lazygit_floating_window_scaling_factor = 1

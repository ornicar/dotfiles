" === Plug Tig ===

nmap ti :Tig<cr>

" === Plug autoformat ===

nmap <leader>i <Esc>:Autoformat<cr>:w<cr>

" === Plug commentary ===

nmap <leader>c<space> <Plug>CommentaryLine
vmap <leader>c<space> <Plug>Commentary

" === Plug BufStop ===

let g:BufstopKeys = "arstdhneio1234567890"

nmap <leader>mt :BufstopMode<CR>

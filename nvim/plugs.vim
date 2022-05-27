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

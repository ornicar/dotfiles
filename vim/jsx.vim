let g:syntastic_javascript_checkers = ['eslint']
let g:jsx_ext_required = 0
autocmd FileType javascript nmap <leader>i <Esc>:nohl<cr>mygg=G,I'y:w<cr>

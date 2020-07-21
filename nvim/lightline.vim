" === Plug lightline ===

let g:lightline = {
      \   'colorscheme': 'one',
      \   'active': {
      \     'left': [
      \       [ 'mode', 'paste' ],
      \       [ 'coc_errors', 'coc_warnings', 'coc_ok' ],
      \       [ 'coc_status'  ],
      \       [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ]
      \     ]
      \   },
      \   'component_function': {
      \     'gitbranch': 'FugitiveHead'
      \   },
      \ }

" register compoments:
call lightline#coc#register()

" === Plug lightline ===

let g:lightline = {
      \   'colorscheme': 'one',
      \   'active': {
      \     'left': [
      \       [ 'mode', 'paste' ],
      \       [ 'coc_errors', 'coc_warnings', 'coc_ok' ],
      \       [ 'coc_status' ],
      \       [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ]
      \     ]
      \   },
      \   'component_function': {
      \     'gitbranch': 'FugitiveHead'
      \   },
      \   'mode_map': {
      \     'n' : 'N',
      \     'i' : 'I',
      \     'R' : 'R',
      \     'v' : 'v',
      \     'V' : 'V',
      \     "\<C-v>": 'V',
      \     'c' : 'C',
      \     's' : 'S',
      \     'S' : 'SL',
      \     "\<C-s>": 'SB',
      \     't': 'T',
      \   }
      \ }

" register compoments:
" call lightline#coc#register()

" === Plug lightline ===

let g:lightline = {
      \   'colorscheme': 'one',
      \   'active': {
      \     'left': [
      \       [ 'mode', 'paste' ],
      \       [ 'coc_errors', 'coc_warnings', 'coc_ok' ],
      \       [ 'coc_status', 'coc_diag'  ],
      \       [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ]
      \     ]
      \   },
      \   'component_function': {
      \     'gitbranch': 'FugitiveHead',
      \     'coc_diag': 'CocFullDiagnostics'
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
call lightline#coc#register()

function! CocFullDiagnostics() abort
  let diagnostics = CocAction('diagnosticList')
  if type(diagnostics) == v:t_list
    let errors = []
    let warnings = []
    for diagnostic in diagnostics
      if diagnostic['severity'] == 'Error'
        call add(errors, diagnostic)
      endif
      if diagnostic['severity'] == 'Warning'
        call add(warnings, diagnostic)
      endif
    endfor
    return " E " . string(len(errors)) . " W " . string(len(warnings))
  endif
endfunction

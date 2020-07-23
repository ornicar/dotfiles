" === Plug fzf ===

let g:fzf_tags_command = 'ctags --recurse --options=.ctags'

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

nnoremap <leader>ms :<C-u>GFiles<cr>
nnoremap <leader>mf :<C-u>Files<cr>
nnoremap <leader>mb :Buffers<cr>
nnoremap <leader>mr :Files <C-R>=expand('%:h')<CR><CR>
nnoremap <leader>ma :Rg<cr>
nnoremap <leader>za mA:Rg <C-r>=expand("<cword>")<cr><cr>
nnoremap <leader>md :b#<cr>               " Previous buffer
nnoremap <leader>H :Helptags<cr>

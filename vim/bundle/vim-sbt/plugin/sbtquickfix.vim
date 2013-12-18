set errorformat=%E\ %#[error]\ %#%f:%l:\ %m,%-Z\ %#[error]\ %p^,%-C\ %#[error]\ %m
set errorformat+=,%W\ %#[warn]\ %#%f:%l:\ %m,%-Z\ %#[warn]\ %p^,%-C\ %#[warn]\ %m
set errorformat+=,%-G%.%#

let s:relativeQFLocation = "target/quickfix/sbt.quickfix"

function! sbtquickfix#LoadQuickFix()
  " Only works on *nixes
  let path = split(expand("%:p:h"), "/")
  let found = 0
  while !found && len(path) != 0
    let file = "/" . join(path, "/") . "/" . s:relativeQFLocation
    if filereadable(file)
      exec ":cf " . file
      return
    endif
    let path = path[0:-2]
  endwhile
  echoerr "Unable to locate quickfix file"
endfunction

let g:quickfix_load_mapping="<leader>ff"
let g:quickfix_next_mapping="<leader>fn"

function! s:MakeMappings()
  if g:quickfix_load_mapping != ""
    exec ":nnoremap <silent> <buffer> " . g:quickfix_load_mapping . " :call sbtquickfix#LoadQuickFix()<cr>"
  endif
  if g:quickfix_next_mapping != ""
    exec ":nnoremap <silent> <buffer> " . g:quickfix_next_mapping . " :cn<cr>"
  endif
endfunction

augroup SbtVim
  autocmd!
  autocmd BufRead *.scala call s:MakeMappings()
augroup END

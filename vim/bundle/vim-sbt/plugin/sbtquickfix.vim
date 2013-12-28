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

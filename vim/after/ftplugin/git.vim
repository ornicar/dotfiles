" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

"1s/^$//e
"goto 1
"startinsert

" Fast save and quit
nmap <buffer> q :wq<CR>

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" don't use cindent for javascript
setlocal nocindent

" Autoclose brackets
imap <buffer> {<cr> {<cr>}<esc>O

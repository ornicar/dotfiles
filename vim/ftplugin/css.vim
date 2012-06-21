" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal number
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab

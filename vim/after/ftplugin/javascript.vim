" Only do this when not done yet for this buffer
if exists("b:javascript_ftplugin_loaded")
    finish
endif
let b:javascript_ftplugin_loaded = 1

" don't use cindent for javascript
setlocal nocindent

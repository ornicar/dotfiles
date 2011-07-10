" Only do this when not done yet for this buffer

" If 'filetype' isn't "man", we must have been called to only define ":Man".
if &filetype == "man"

    if exists("b:did_ftplugin")
        finish
    endif
    let b:did_ftplugin = 1

    " Quit man with q
    map <buffer> q :q<cr>
endif

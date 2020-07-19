1s/^$//e
goto 1
startinsert

" save and quit, enven during insert
map <C-e> :nohl<cr>:wq<cr>
imap <C-e> <esc>:nohl<cr>:wq<cr>

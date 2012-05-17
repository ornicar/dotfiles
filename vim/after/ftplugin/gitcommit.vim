1s/^$//e
goto 1
startinsert

" save and quit, enven during insert
map <C-u> :nohl<cr>:wq<cr>
imap <C-u> <esc>:nohl<cr>:wq<cr>

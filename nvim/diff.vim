" === Diff ===

set diffopt=filler,horizontal,context:4,iwhite

if &diff
  nmap <leader>do :diffget<space>
  nmap <leader>dp :diffput<space>
  nmap <leader>q :wqa<cr>
  nmap <leader><space> <C-w>l<C-w>q<C-w>j<C-w>L<C-w>h
else
  nmap <leader>q :wq<cr>
endif

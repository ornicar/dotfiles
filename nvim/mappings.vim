" === Basic mappings

nmap <leader>sm :source $MYVIMRC<cr>

noremap H ^
noremap L $
nmap ! :!

" Toggle nowrap
nnoremap <silent> <leader>nw :set nowrap!<cr>

" Close other windows
map <leader>wo :only<cr>

" Move in windows
map <leader>ww :wincmd w<cr>
map <leader>wh :wincmd h<cr>
map <leader>wj :wincmd j<cr>
map <leader>wk :wincmd k<cr>
map <leader>wl :wincmd l<cr>

nmap <leader>md :b#<cr>                         " Previous buffer
nmap <leader>wd :bd<cr>                         " delete buffer
nmap <leader>wD :!rm %<cr>:bd!<cr>              " delete buffer and file

" Copy current file path to registers "* and "+
nmap <leader>cp :let @*=@%<cr>:let @+=@%<cr>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Use space as " shortcut
nmap <space> "
vmap <space> "

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'
nmap <silent> gW :s/\(\%#[^\s]\+\)\(\_W\+\)\([^\s]\+\)/\3\2\1/<CR>`'

" Clear search highlight
nmap <silent> <leader>/ :nohl<cr>

" Start a substitute
nmap <leader>ss :%s/\v

" Pull word under cursor into LHS of a substitute (for quick search and replace)
nmap <leader>zs :%s#<C-r>=expand("<cword>")<cr>#

" Use perl regex style
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Search to quickfix
nmap <leader>rg :Rg<space>

" Open omnicomplete with tab
inoremap <Tab> <C-x><C-o>

" Fast save (also clears the search)
map <C-e> :nohl<cr>:w<cr>
imap <C-e> <esc>:nohl<cr>:w<cr>

" Previous element during omnicomplete (<C-e> is used for fast save)
imap <expr> <C-k> pumvisible() ? '<C-p>' : '<C-k>'

" Reselect text that was just pasted with ,v
nnoremap <leader>v V`]

" wordwise yank from line above
inoremap <silent> <C-Y> <C-C>:let @z = @"<cr>mz
      \:exec 'normal!' (col('.')==1 && col('$')==1 ? 'k' : 'kl')<cr>
      \:exec (col('.')==col('$')-1 ? 'let @" = @_' : 'normal! yw')<cr>
      \`zp:let @" = @z<cr>a

" Don't use Ex mode; use Q for console mode
map Q q:

" Fast file renaming
nmap R :let _pfn="<C-R>=expand("%:.")<cr>"<cr>q:iRename <C-R>=expand(_pfn)<cr><esc>^w

" Make the current file executable
nmap <leader>% :!chmod +x %<cr>

" nmap <leader>rr :redraw!<cr>

" Expand current filed dir in console mode
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Jump to line AND col
nnoremap ' `

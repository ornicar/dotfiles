" Vim configuration - Thibault Duplessis.

set nocompatible
let mapleader = ","

filetype off                    " force reloading *after* pathogen loaded

" Load bundles help
silent! call pathogen#helptags()
" Load bundles code
silent! call pathogen#runtime_append_all_bundles()

filetype plugin indent on       " enable detection, plugins and indenting in one step

" Colorsheme
set t_Co=256
colorscheme aldmeris255

" Sets how many lines of history VIM has to remember
set history=2000

set undolevels=1000             " use many levels of undo
set noundofile                  " Don't keep a persistent undofile

" Disable spell checking
set nospell

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set wildignore=*.pyc,*.pyo,*/cache/**,*/logs/**,*/zend/** " Ignore certain files

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set showmatch                     " Show matching char (like {})

set wrap                          " Turn on line wrapping.
set scrolloff=7                   " Show 7 lines of context around the cursor.
set sidescrolloff=7

set notitle                       " Do not set the terminal's title

set visualbell                    " No beeping.

set shortmess+=filmnrxoOtT     	  " abbrev. of messages (avoids 'hit enter')

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile                    " Use an SCM instead of swap files

set laststatus=2                   " Show the status line all the time
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\(%{getcwd()})%=%-16(\ %l,%c-%v\ %)%P

" Tabs and indentation.
set expandtab
set autoindent
set smartindent

" Configure tabstyle...
set tabstop=4
set shiftwidth=4

" But make it easy to switch it
nmap <leader>2 :set tabstop=2<cr>:set shiftwidth=2<cr>
nmap <leader>4 :set tabstop=4<cr>:set shiftwidth=4<cr>

" Use perl regex style
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Always replace all occurences of a line
set gdefault

" Highlight current line
set cursorline

" Reduce timeout for key codes
set timeout timeoutlen=800 ttimeoutlen=0

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Open man pages
runtime! ftplugin/man.vim

" Round indent to shiftwidth
set shiftround

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,css,html,xml,yml,vim autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"Syntax
syntax enable

" Allow extended digraphs
set encoding=utf-8

" Enable folding by indentation
set foldmethod=indent
set fillchars=fold:⋯
" go to next fold and open it
map zz zjzo
" Disable folding by default
set nofoldenable

" Change statusbar color
au InsertEnter * hi StatusLine ctermfg=16 ctermbg=214
au InsertEnter * hi LineNr     ctermfg=214 ctermbg=16
au InsertLeave * hi StatusLine ctermfg=16 ctermbg=240
au InsertLeave * hi LineNr     ctermfg=8 ctermbg=16

" Delete buffer
nmap <leader>d :bd<cr>

" Delete buffer and file
nmap <leader>D :!rm %<cr>:bd!<cr>

" Copy current file path to register "*
nmap <leader>cp :let @*=@%<cr>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Paste from system register
nnoremap 1p "*p

" In system register "+
nmap + "+

" My information
iab xdate =strftime("%d/%m/%Y %H:%M:%S")
iab xname Thibault Duplessis
iab xsigp Thibault Duplessis
iab xsigw Thibault Duplessis

" Diff only config
if &diff
    nmap <leader>do :diffget<space>
    nmap <leader>dp :diffput<space>
    nmap <leader>q :wqa<CR>
    nmap <leader><space> <C-w>l<C-w>q<C-w>j<C-w>L<C-w>h
endif

set diffopt=filler,vertical

" Fast open vertical buffer
nmap <Leader>vb :vsp^M^W^W<cr>

" Fast open vertical help
nmap <Leader>h <Esc>:vert help<space>

" Clear search highlight
map <silent> <leader>/ :let @/=""<CR>:echo "Cleared search register."<cr>

" Pull word under cursor into LHS of a substitute (for quick search and replace)
nmap <leader>zs :%s#\<<C-r>=expand("<cword>")<CR>\>#

" Pull word under cursor into Ack for a global search
map <leader>za :Ack "<C-r>=expand("<cword>")<CR>"

" Start a substitute
map <leader>s :%s/\v

" Jump to line AND col
nnoremap ' `

" Faster viewport scrolling
noremap <C-j> 3j
noremap <C-k> 3k

" Fast save
map <Leader>w :w<CR>

" Sudo to write
cmap :w silent write !sudo tee % >/dev/null

" Reselect text that was just pasted with ,v
nnoremap <leader>v V`]

" http://vim.wikia.com/wiki/Search_for_visually_selected_text
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Detect twig filetype
au BufNewFile,BufRead *.twig set filetype=htmljinja

" Navigate in quickfix window
nmap ]q :<C-U>exe "cnext ".(v:count ? v:count : "")<CR>
nmap [q :<C-U>exe "cprevious ".(v:count ? v:count : "")<CR>

" Remap ( and ) to beggining and end of the line
map ( ^
map ) $

" CTAGS
" Explore tags for the word under the cursor
"map <C-l> <C-]>
" Jump to next tag match
map ]t :tnext<CR>
" Jump to previous tag match
map [t :tprevious<CR>
" Open tag command
nmap <leader>t :tag<space>

" Lusty
map <leader>lp :LustyJugglePrevious<cr>
let g:LustyJugglerShowKeys = 0

" Syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_quiet_warnings=0
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Snipmate
let g:snips_author = 'Thibault Duplessis <thibault.duplessis@gmail.com>'

" Ack
let g:ackprg="ack -H --nocolor --nogroup --column"
nmap <leader>a :Ack<space>

" Command-T
nmap <silent> <leader>f :CommandT<CR>
" Increase cache size
let g:CommandTMaxFiles = 30000
let g:CommandTMatchWindowAtTop = 1

" Processing results in quickfix http://efiquest.org/2009-02-19/32/
com! -nargs=1 Qfdo try | sil cfirst |
\ while 1 | exec <q-args> | sil cn | endwhile |
\ catch /^Vim\%((\a\+)\)\=:E\%(553\|42\):/ |
\ endtry
com! -nargs=1 Qfdofile try | sil cfirst |
\ while 1 | exec <q-args> | sil cnf | endwhile |
\ catch /^Vim\%((\a\+)\)\=:E\%(553\|42\):/ |
\ endtry

" Gist
let g:gist_open_browser_after_post = 1

" Use ranger as vim file manager
function! Ranger()
  silent !ranger --choosefile=/tmp/chosen
  if filereadable('/tmp/chosen')
    exec 'edit ' . system('cat /tmp/chosen')
    call system('rm /tmp/chosen')
  endif
  redraw!
endfunction

nmap <leader>r :call Ranger()<cr>

" Show the group name of the word under the cursor
"map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
"\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
"\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Source local settings
if filereadable("~/.vimrc.local")
    source ~/.vimrc.local
endif

" Vim configuration - Thibault Duplessis.

set nocompatible                  " Must come first because it changes other options.

let mapleader = ","

" Source local settings
if filereadable("~/.vimlocalrc")
    source ~/.vimlocalrc
endif

" Colorsheme
set t_Co=256
colorscheme amonsul

" Remove menu bar
set guioptions-=m
" Remove toolbar
set guioptions-=T
" Remove scrollbar
set guioptions-=r

set langmenu=en_US.UTF-8

silent! call pathogen#helptags()
silent! call pathogen#runtime_append_all_bundles()

" runtime macros/matchit.vim        " Load the matchit plugin.

" Sets how many lines of history VIM has to remember
set history=1000

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set wildignore=*/cache/**,*/logs/** " Ignore certain files

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set showmatch                     " Show matching char (like {})

set wrap                          " Turn on line wrapping.
set scrolloff=7                   " Show 7 lines of context around the cursor.
set sidescrolloff=7

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location
set noswapfile                    " Use an SCM instead of swap files

set laststatus=2                  " Show the status line all the time
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ (%{getcwd()})%=%-16(\ %l,%c-%v\ %)%P

set shortmess+=I                  " Don't show splash screen

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

" Always replace all occurences of a line
set gdefault

" Change the status line color based on mode
if version >= 700
  au InsertEnter * hi StatusLine guibg=#EED365 guifg=#111111
  au InsertLeave * hi StatusLine guibg=#334b7d guifg=#FFFFFF
endif

" Highlight current line http://vim.wikia.com/wiki/Highlight_current_line
set cursorline

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

set shiftround

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"Syntax
syntax enable                     " Turn on syntax highlighting.
filetype on
filetype plugin on
filetype indent on

" Allow extended digraphs
set encoding=utf-8

" Enable folding by indentation
" Use: zc, zo, zC, zO, zR, zM
" Ctrl-K .3 for ⋯
" set foldmethod=indent
highlight Folded ctermfg=red
highlight FoldColumn ctermfg=white
set fillchars=fold:⋯

" My information
iab xdate =strftime("%d/%m/%Y %H:%M:%S")
iab xname Thibault Duplessis
iab xsigp Thibault Duplessis
iab xsigw Thibault Duplessis

" Strip trailing whitespace in whole file
func! StripTrailingWS()
%s/\s\+$//
endfunc
command! StripTrailingWS call StripTrailingWS()

" Fast save
nmap <Leader>w :w<CR>

" CLear search highlight
nmap <silent> <leader>/ :let @/=""<CR>

" Jump to line AND col
nnoremap ' `

" Faster viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
nnoremap <C-j> 3j
nnoremap <C-k> 3k

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
au BufNewFile,BufRead *.twig			setf htmljinja

" lowercase to modulized
nnoremap _ bf_x~

" CTAGS
" Explore tags for the word under the cursor
map <C-l> <C-]>
" Back to previous location after browsing tags
map <C-h> <C-T>
" Jump to next tag match
map ]t :tnext<CR>
" Jump to previous tag match
map [t :tprevious<CR>
" Open tag command
map <C-T> :tag 
let g:Tlist_Ctags_Cmd = 'ctags'
" Rebuild tag index
nnoremap <silent> <C-F7> :silent !ctags-exuberant -h ".php" --PHP-kinds=+cf --recurse --exclude=*/cache/* --exclude=*/logs/* --exclude=*/data/* --exclude="\.git" --exclude="\.svn" --languages=PHP &<cr>:CommandTFlush<cr>
" TagList
let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "name"
nnoremap <silent> <F7> :TlistToggle<CR>

" Lusty
map <leader>lp :LustyJugglePrevious<cr>
let g:LustyJugglerShowKeys = 0

" Nerd Tree
map <Leader>nf :NERDTree<Enter>
map <Leader>nr :NERDTree %:p:h<Enter>
let NERDTreeQuitOnOpen=1

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
let g:ackprg="ack-grep -H --nocolor --nogroup --column --type-add html=twig --ignore-dir=cache --ignore-dir=logs --ignore-dir=tmp"
nmap <leader>a :Ack 

" Command-T
" Unmap the default mapping (<leader>t)
nmap <silent> <leader>t :<cr>
" Map to <leader>f
nmap <silent> <leader>f :CommandT<CR>
" Increase cache size
let g:CommandTMaxFiles = 30000
let g:CommandTMatchWindowAtTop = 1

" Colorsheme switcher
source $HOME/.vim/bundle/scrollcolor/ScrollColor.vim
map <silent><F3> :NEXTCOLOR<cr> 
map <silent><F2> :PREVCOLOR<cr>

" Gist
let g:gist_open_browser_after_post = 1

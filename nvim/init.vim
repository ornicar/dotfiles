" Vim configuration - Thibault Duplessis.

" vim-plug
call plug#begin(stdpath('data') . '/plugged')
" Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf.vim'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'codeindulgence/vim-tig'
" Plug 'rbgrouleff/bclose.vim' " for tig
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'
call plug#end()

let g:mapleader = ","

" === Basic settings ===

set termguicolors
syntax on
colorscheme onedark

set autoread                      " Automatically read a file that has changed on disk

set clipboard=unnamed             " Alias unnamed register to the + register, which is the X Window clipboard.

set history=9000                  " Sets how many lines of history VIM has to remember

set undolevels=2000               " use many levels of undo
set undofile                      " persistent

set noshowmode                    " Do not show mode on command line since vim-airline can show it

set hidden                        " Handle multiple buffers better.

set wildmode=list:full            " Complete files like a shell.
set wildignore=.git,.hg,*.o,*.a,*.class,*.jar,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo,**/cache/*,**/logs/*,**/target/*,*.hi,tags,**/dist/*,**/public/**/vendor/**,**/public/vendor/**,**/node_modules/**

set number                        " Show line numbers.
set ruler                         " Show cursor position.
set cursorline

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.
set showmatch                     " Show matching char (like {})
set wrapscan                      " Circle search

set nowrap                        " Turn off line wrapping.
set scrolloff=7                   " Show 7 lines of context around the cursor.
set sidescrolloff=7

set shortmess+=c                  " Do not show "match xx of xx" and other messages during auto-completion

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile                    " Use an SCM instead of swap files

set fillchars=fold:\ ,diff:⣿

" Tabs and indenting
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set smartindent

set gdefault                      " replace all occurences of the line


set cmdwinheight=12               " Larger console window

" === Colemak ===

" next -> down
noremap n j
" Faster viewport scrolling
noremap N 3j
" down -> next
noremap j n
" join lines -> previous
noremap J N
" new mapping for join
noremap <leader>j J

" end -> up
noremap e k
" Faster viewport scrolling
noremap E 3k
" up -> end
noremap k e
" program -> end inclusive
noremap K E

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

" Pull word under cursor into LHS of a substitute (for quick search and replace)
nmap <leader>zs :%s#<C-r>=expand("<cword>")<cr>#

" Use perl regex style
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Start a substitute
nmap <leader>ss :%s/\v

" Fast save (also clears the search)
map <C-e> :nohl<cr>:w<cr>
imap <C-e> <esc>:nohl<cr>:w<cr>

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
nmap <leader>% :Silent chmod +x %<cr>

nmap <leader>rr :redraw!<cr>

" Show sbt errors in quickfix
map <silent> <leader>ff :call sbtquickfix#LoadQuickFix()<cr>
map <silent> <leader>fn :cn<cr>


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


" === Plug fzf ===

nnoremap <leader>mf :<C-u>GFiles<cr>
nnoremap <leader>mt :Buffers<cr>
nnoremap <leader>md :b#<cr>

let g:fzf_tags_command = 'ctags --recurse --options=.ctags'

" === Plug Tig ===

nmap ti :Tig<cr>

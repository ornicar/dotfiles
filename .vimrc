" Vim configuration - Thibault Duplessis.

set nocompatible                  " Must come first because it changes other options.

let mapleader = ","

if has("gui_running")
  colorscheme moria
else
  colorscheme ornicar
endif

set langmenu=en_US.UTF-8

silent! call pathogen#runtime_append_all_bundles()

" runtime macros/matchit.vim        " Load the matchit plugin.

" Sets how many lines of history VIM has to remember
set history=800

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

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
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ (%{getcwd()})%{fugitive#statusline()}%=%-16(\ %l,%c-%v\ %)%P

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Tabs and indentation.
set expandtab
set autoindent

set tabstop=2
set shiftwidth=2

nmap <leader>2 :set tabstop=2<cr>:set shiftwidth=2<cr>
nmap <leader>4 :set tabstop=4<cr>:set shiftwidth=4<cr>

set shiftround

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

" Change current dir (http://vim.wikia.com/wiki/VimTip1185)
nmap <Leader>cd :cd %:p:h<CR>

" MRU (recently opened files)
let MRU_Auto_Close = 1
let MRU_Max_Menu_Entries = 20
nmap <leader>m :MRU<cr>

" Conque (shell in vim)
nmap <leader>c :ConqueTermVSplit bash<cr>

" PHP
let php_sql_query = 1 "Coloration des requetes SQL
let php_htmlInStrings = 1 "Coloration des balises HTML

" phpdoc
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-P> :call PhpDocSingle()<CR> 
vnoremap <C-P> :call PhpDocRange()<CR> 
let g:pdv_cfg_Author = "Thibault Duplessis <thibault.duplessis@gmail.com>"
let g:pdv_cfg_License = "MIT {@link http://opensource.org/licenses/mit-license.html}"
let g:pdv_cfg_Copyright = "2010"
let g:pdv_cfg_php4always = 0 " Ignore PHP4 tags

" TagList
let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "name"
nnoremap <silent> <F7> :TlistToggle<CR>

" Lusty
source $HOME/.vim/bundle/lusty/lusty-explorer.vim
source $HOME/.vim/bundle/lusty/lusty-juggler.vim
map <leader>lp :LustyJugglePrevious<cr>

" CTAGS
map <C-h> <C-T>
map <C-l> <C-]>

" Tabs
map <leader>tt :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Buffers
" Close the current buffer
map <leader>bd :bdelete<cr>

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
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Command-T
" Unmap the default mapping (<leader>t)
nmap <silent> <leader>t :<cr>
" Map to <leader>f
nmap <silent> <leader>f :CommandT<CR>
" Increase cache size
let g:CommandTMaxFiles = 30000

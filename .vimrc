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
set history=200

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
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ (%{getcwd()})%=%-16(\ %l,%c-%v\ %)%P

" Reload this file
nmap <leader>s :source $MYVIMRC<cr>

" now set it up to change the status line based on mode
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

" Tabs and indentation.
set expandtab
set autoindent

set tabstop=4
set shiftwidth=4

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

" Fast save
nmap <Leader>w :w<CR>

" Indent PHP templates as HTML files
nmap <leader>= :set ft=html<cr>mhgg=G'h:set ft=php<cr>
" Indent whole PHP file
nmap <leader>i <Esc>mygg=G'y

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

" TwitVim
source $HOME/.vim/private/twitvim.vim " twitter password
nnoremap <F8> :FriendsTwitter<cr>
let twitvim_browser_cmd="firefox"
let twitvim_count = 50

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

" CTAGS
map <C-h> <C-T>
map <C-l> <C-]>
let g:Tlist_Ctags_Cmd = 'ctags'
nnoremap <silent> <C-F7> :silent !ctags --recurse --exclude=*/zend/* --exclude=*/cache/* --exclude=*/logs/* --exclude=*/data/* --languages=PHP &<cr>

" TagList
let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "name"
nnoremap <silent> <F7> :TlistToggle<CR>

" Lusty
map <leader>lp :LustyJugglePrevious<cr>
let g:LustyJugglerShowKeys = 1

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

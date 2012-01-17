" Vim configuration - Thibault Duplessis.

set nocompatible

" Infect Vim with pathogen >:)
call pathogen#infect()

syntax on
filetype plugin indent on       " enable detection, plugins and indenting in one step

" Colorsheme
set t_Co=16
let g:solarized_termcolors=16
let g:solarized_termtrans=0
let g:solarized_menu=0
let g:solarized_italic=0
set background=dark
colorscheme solarized

let mapleader = ","


set autoread                      " Automatically read a file that has changed on disk

set clipboard=unnamedplus         " Alias unnamed register to the + register, which is the X Window clipboard.

set history=2000                  " Sets how many lines of history VIM has to remember

set undolevels=1000               " use many levels of undo
set noundofile                    " Don't keep a persistent undofile

set nospell                       " Disable spell checking

set lazyredraw                    " make plugins smoother

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo,**/cache/**,**/logs/**,**/zend/**,**/bootstrap.*,**/vendor/**/vendor/**,web/css,web/js,web/bundles,*/project/*,*/target/*,*.hi,tags

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

set shortmess+=filmnrxoOtT        " abbrev. of messages (avoids 'hit enter')

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile                    " Use an SCM instead of swap files

set laststatus=2                   " Show the status line all the time
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\(%{substitute(getcwd(),'^.*/','','')})%{fugitive#statusline()}%=%-16(\ %l,%c-%v\ %)%P

" Tabs and indentation.
set expandtab
set autoindent
set smartindent

" Configure tabstyle...
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Not sure what this does
set ttyfast

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=1024

" But make it easy to switch it to 2 or 4 spaces
nmap <leader>2 :set tabstop=2<cr>:set shiftwidth=2<cr>
nmap <leader>4 :set tabstop=4<cr>:set shiftwidth=4<cr>

" Or even hard tabs
let tab_width=4
function! TabToggle()
  if &expandtab
    set shiftwidth=4
    set softtabstop=0
    set noexpandtab
    echo "Hard tabs on"
  else
    execute "set shiftwidth=".g:tab_width
    execute "set softtabstop=".g:tab_width
    set expandtab
    echo "Hard tabs off"
  endif
endfunction
nmap <leader><tab> mz:execute TabToggle()<cr>'z

" Use perl regex style
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Execute external command
nmap ! :!

" Always replace all occurences of a line
set gdefault

" Highlight the current line and column
" Don't do this - It makes window redraws painfully slow
set nocursorline
set nocursorcolumn

" Reduce timeout for key codes
set timeout timeoutlen=500 ttimeoutlen=0

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
autocmd FileType c,cpp,java,php,js,css,html,xml,yml,vim,scala,haskell
    \ autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

set encoding=utf-8

" Enable folding by indentation
set foldmethod=indent
set fillchars=fold:⋯,diff:⣿
" go to next fold and open it
map zz zjzo
" Disable folding by default
set nofoldenable

" Change statusbar color
"au InsertEnter * hi StatusLine ctermfg=16 ctermbg=214
"au InsertEnter * hi LineNr     ctermfg=214 ctermbg=16
"au InsertLeave * hi StatusLine ctermfg=242 ctermbg=233
"au InsertLeave * hi LineNr     ctermfg=238 ctermbg=233

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $

" Move insertion to correct indentation
imap <C-s> <esc>S

" Toggle line numbering
nnoremap <silent> <leader>nn :set nonumber!<cr>

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

" Configure buffer explorer
let g:bufExplorerShowRelativePath=1  " Show relative paths.

" Delete buffer
nmap <leader>wd :bd<cr>

" Delete buffer and file
nmap <leader>wD :!rm %<cr>:bd!<cr>

" Copy current file path to registers "* and "+
nmap <leader>cp :let @*=@%<cr>:let @+=@%<cr>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Use space as " shortcut
nmap <space> "
vmap <space> "

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" My information
iab xdate =strftime("%d/%m/%Y %H:%M:%S")
iab xname Thibault Duplessis
iab xsigp Thibault Duplessis
iab xsigw Thibault Duplessis

" Diff only config
if &diff
    nmap <leader>do :diffget<space>
    nmap <leader>dp :diffput<space>
    nmap <leader>q :wqa<cr>
    nmap <leader><space> <C-w>l<C-w>q<C-w>j<C-w>L<C-w>h
else
    nmap <leader>q :wq<cr>
endif

set diffopt=filler,vertical
set diffopt+=iwhite

" Fast open vertical help
nmap <leader>h <Esc>:vert help<cr>:vert resize 80<cr>:vert help<space>

" Clear search highlight
nmap <silent> <leader>/ :nohl<cr>

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>

" Replace what's selected
vnoremap <C-h> ""y:%s/<C-R>=escape(@", '/\')<cr>//g<Left><Left>

" Pull word under cursor into LHS of a substitute (for quick search and replace)
nmap <leader>zs :%s#<C-r>=expand("<cword>")<cr>#

" Ack
let g:ackprg="ack -H --nocolor --nogroup --column"
" Set a mark then search with Ack
nmap <leader>a mA:Ack<space>
" Set a mark, then pull word under cursor into Ack for a global search
nmap <leader>za mA:Ack "<C-r>=expand("<cword>")<cr>"

" Align
" Disable default mappings
let g:loaded_AlignMapsPlugin=1

vnoremap a :Align<space>

" Start a substitute
nmap <leader>ss :%s/\v

" Indent whole file
nmap <leader>i <Esc>mygg=G'y

" Expand current filed dir in console mode
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Jump to line AND col
nnoremap ' `

" Sane moves in wrapped lines
" nnoremap j gj
" nnoremap k gk

" Fast save (also clears the search)
map <tab> :nohl<cr>:w<cr>

" Sudo to write
cmap w!! silent write !sudo tee % >/dev/null

" Reselect text that was just pasted with ,v
nnoremap <leader>v V`]

" wordwise yank from line above
inoremap <silent> <C-Y> <C-C>:let @z = @"<cr>mz
    \:exec 'normal!' (col('.')==1 && col('$')==1 ? 'k' : 'kl')<cr>
    \:exec (col('.')==col('$')-1 ? 'let @" = @_' : 'normal! yw')<cr>
    \`zp:let @" = @z<cr>a

" Visual Mode */# from Scrooloose
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<cr>//<cr><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<cr>??<cr><c-o>

" Navigate in quickfix window
nmap ]q :<C-U>exe "cnext ".(v:count ? v:count : "")<cr>
nmap [q :<C-U>exe "cprevious ".(v:count ? v:count : "")<cr>

" Don't use Ex mode; use Q for console mode
map Q q:

" Larger console window
set cmdwinheight=12

" Fast, efficient file renaming
nmap R :let _pfn="<C-R>=expand("%:.")<cr>"<cr>q:iRename <C-R>=expand(_pfn)<cr><esc>^w

" Use dmenuclip to paste from a previous X clipboard
nmap <leader>p :r !dmenuclip<cr>

" Make the current file executable
nmap <leader>% :Silent chmod +x %<cr>

" CTAGS
" Rebuild tags
nmap <leader>ct :!ctags&<cr><cr>
" Jump to next tag match
nmap ]t :bd<cr>:tnext<cr>
" Jump to previous tag match
nmap [t :bd<cr>:tprevious<cr>

" Surround mappings
let g:surround_no_mappings = 1
nmap ds  <Plug>Dsurround
nmap cs  <Plug>Csurround
nmap ys  <Plug>Ysurround
nmap yS  <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround

" Show git log for the current file
nmap <leader>gl :Git log -p %<cr>

" Configure supertab
let g:SuperTabCrMapping = 0

" Lusty juggler
let g:LustyJugglerDefaultMappings = 0
let g:LustyJugglerShowKeys = 0
nmap <silent> <leader>md :LustyJugglePrevious<cr>
nmap <silent> <leader>mt :LustyJuggler<cr>

" Lusty buffer
"nmap <silent> <leader>mb :LustyBufferExplorer<cr>
nmap <silent> <leader>mg :LustyBufferGrep<cr>

" Lusty explorer
let g:LustyExplorerDefaultMappings = 0
nmap <silent> <leader>ms :LustyFilesystemExplorer<cr>
nmap <silent> <leader>mr :LustyFilesystemExplorerFromHere<cr>

" CtrlP search
let g:ctrlp_max_height = 30
let g:ctrlp_jump_to_buffer = 1 " switch to already opened buffer
let g:ctrlp_working_path_mode = 0
let g:ctrlp_open_new_file = 3 " open in current window
let g:ctrlp_extensions = ['tag']
nmap <silent> <leader>mf :CtrlP<cr>
nmap <silent> <leader>mF :ClearCtrlPCache<cr>:CtrlP<cr>
nmap <silent> <leader>mb :CtrlPBuffer<cr>
nmap <silent> <leader>t :CtrlPTag<cr>

let g:NERDCustomDelimiters = {
    \ 'haskell': { 'left': '--' , 'right': '' },
    \ 'hamlet' : { 'left': '\<!-- ', 'right': ' -->' },
    \ 'cassius': { 'left': '/* ' , 'right': ' */' },
    \ 'lucius' : { 'left': '/* ' , 'right': ' */' },
    \ 'julius' : { 'left': '//' , 'right': '' }
\ }

" Redraw
nmap <leader>rr :redraw!<cr>

" Filetype detection extensions
au BufNewFile,BufRead *vimperatorrc*,*.vimp set filetype=vimperator
au BufNewFile,BufRead *.twig set filetype=twig
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.rc set filetype=conf
au BufNewFile,BufRead *.muttrc set filetype=muttrc

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
let g:gist_browser_command = "browser %URL% &"

" Run an external program through silent without messing up the screen in CLI
command! -nargs=1 Silent
\ | execute ':silent !'.<q-args>
\ | execute ':redraw!'

" Use ranger r vim file manager
function! Ranger()
    silent !ranger --choosefile=/tmp/chosen
    if filereadable('/tmp/chosen')
        exec 'edit ' . system('cat /tmp/chosen')
        call system('rm /tmp/chosen')
    endif
    redraw!
endfunction
nmap <leader>R :call Ranger()<cr>

" Show differences between buffer and saved versions of a file
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

"  Clean code function
function! CleanCode()
    %retab          " Replace tabs with spaces
    %s/\r/\r/eg     " Turn DOS returns ^M into real returns
    %s=  *$==e      " Delete end of line blanks
    echo "Cleaned up this mess."
endfunction
nmap <leader>cc :call CleanCode()<cr>

" Show the group name of the word under the cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

" Source local settings
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

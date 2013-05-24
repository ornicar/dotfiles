" Vim configuration - Thibault Duplessis.

set nocompatible

" Infect Vim with pathogen >:)
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

syntax on
filetype plugin indent on       " enable detection, plugins and indenting in one step

" Colorsheme
set t_Co=16
let g:solarized_termcolors=16
let g:solarized_termtrans=0
let g:solarized_menu=0
let g:solarized_italic=1
set background=dark
colorscheme solarized

let mapleader = ","

set autoread                      " Automatically read a file that has changed on disk

set clipboard=unnamedplus         " Alias unnamed register to the + register, which is the X Window clipboard.

set history=9000                  " Sets how many lines of history VIM has to remember

set undolevels=2000               " use many levels of undo
set undodir=~/.cache/vim/undo      " persistent undo
set undofile

set nospell                       " Disable spell checking

set lazyredraw                    " make plugins smoother

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.jar,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo,**/cache/*,**/logs/*,play-*,**/target/*,*.hi,tags,**/dist/*,**/public/**/vendor/**,**/public/vendor/**

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set showmatch                     " Show matching char (like {})
set wrapscan                      " Circle search

set nowrap                        " Turn off line wrapping.
set scrolloff=7                   " Show 7 lines of context around the cursor.
set sidescrolloff=7

set notitle                       " Do not set the terminal's title

set visualbell                    " No beeping.

set shortmess+=filmnrxoOtT        " abbrev. of messages (avoids 'hit enter')

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile                    " Use an SCM instead of swap files

set laststatus=2                   " Show the status line all the time
" set statusline=%{substitute(getcwd(),'^.*/','','')}\ [%n]\ %<%.99f\ %h%w%m%r%y%{fugitive#statusline()}%=%-16(\ %l,%c-%v\ %)%P
set statusline=%{substitute(getcwd(),'^.*/','','')}\ %<%.99f\ %h%w%m%r%y%=%-16(\ [%{getfsize(expand('%%:p'))}]\ %l,%c-%v\ %)%P

" Tabs and indentation.
set expandtab
set autoindent
set smartindent

" Configure tabstyle...
set tabstop=2
set softtabstop=2
set shiftwidth=2

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

" Not sure what this does
set ttyfast

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=1024

" Display invisible chars
set listchars=tab:▸\ ,trail:□,eol:¬
" Not by default
set nolist

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

set encoding=utf-8

" Enable folding by indentation
set foldmethod=indent
set fillchars=fold:\ ,diff:⣿
" open/close fold
map <space><space> zA
" go to next fold and open it
map <leader><space><space> zjzo
" Disable folding by default
" zi toggles the folding
set nofoldenable

" Change statusbar color
"au InsertEnter * hi StatusLine ctermfg=16 ctermbg=214
"au InsertEnter * hi LineNr     ctermfg=214 ctermbg=16
"au InsertLeave * hi StatusLine ctermfg=242 ctermbg=233
"au InsertLeave * hi LineNr     ctermfg=238 ctermbg=233

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $

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
nmap <silent> gW :s/\(\%#[^\s]\+\)\(\_W\+\)\([^\s]\+\)/\3\2\1/<CR>`'

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
nmap <leader>H <Esc>:vert help<cr>:vert resize 80<cr>:vert help<space>

" Clear search highlight
nmap <silent> <leader>/ :nohl<cr>

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>

" Replace what's selected
vnoremap <C-h> ""y:%s/<C-R>=escape(@", '/\')<cr>//g<Left><Left>

" Pull word under cursor into LHS of a substitute (for quick search and replace)
nmap <leader>zs :%s#<C-r>=expand("<cword>")<cr>#

" Global quick search-replace
nmap <leader>sr :!ack -l <C-r>=expand("<cword>")<cr> \|
      \ xargs perl -pi -E 's/<C-r>=expand("<cword>")<cr>//g'<left><left><left>

" Ack
let g:ackprg = 'ag --nogroup --nocolor --column'
" Set a mark then search with Ack
nmap <leader>a mA:Ack<space>
" Set a mark, then pull word under cursor into Ack for a global search
nmap <leader>za mA:Ack "<C-r>=expand("<cword>")<cr>"
nmap <leader>zA mA:Ack "<C-r>=expand("<cWORD>")<cr>"

" yuml
nmap <silent> <leader>yu :w !~/.scripts/yuml<cr>

" Start a substitute
nmap <leader>ss :%s/\v

" Remove trailing whitespaces and ^M chars
nmap <leader>I :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))<cr>

" Indent whole file, remove trailing whitespaces then save
nmap <leader>i <Esc>:nohl<cr>mygg=G,I'y:w<cr>

" for js
autocmd FileType javascript noremap <buffer> <leader>i :call JsBeautify()<cr>
" for html
" autocmd FileType html noremap <buffer> <leader>i :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <leader>i :call CSSBeautify()<cr>

" Expand current filed dir in console mode
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Jump to line AND col
nnoremap ' `

" Sane moves in wrapped lines
" nnoremap j gj
" nnoremap k gk

" Fast save (also clears the search)
map <C-u> :nohl<cr>:w<cr>
imap <C-u> <esc>:nohl<cr>:w<cr>

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

" Autoresize quickfix window http://vim.wikia.com/wiki/Automatically_fitting_a_quickfix_window_height
au FileType qf call AdjustWindowHeight(1, 20)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Navigate in quickfix window
nmap ]q :<C-U>exe "cnext ".(v:count ? v:count : "")<cr>
nmap [q :<C-U>exe "cprevious ".(v:count ? v:count : "")<cr>

" Don't use Ex mode; use Q for console mode
map Q q:

" Larger console window
set cmdwinheight=12

" Fast, efficient file renaming
nmap R :let _pfn="<C-R>=expand("%:.")<cr>"<cr>q:iRename <C-R>=expand(_pfn)<cr><esc>^w

" Make the current file executable
nmap <leader>% :Silent chmod +x %<cr>

" haskell vim2hs
let g:haskell_conceal = 1
let g:haskell_conceal_wide = 0
" let g:haskell_conceal_enumerations = 1
" let g:haskell_conceal_comments = 1
" let g:haskell_conceal_bad = 1
let g:haskell_autotags = 1
let g:haskell_tags_generator = 'fast-tags'
let g:hpaste_author = 'github.com/ornicar'
let g:hlint_args = ''

" haskellmode
let g:haddock_browser = 'firefox'
let g:haddock_docdir="/usr/share/doc/ghc/html/"
let g:haddock_indexfiledir=$HOME.'/.cache/'

" commentary
nmap <leader>c<space> <Plug>CommentaryLine
vmap <leader>c<space> <Plug>Commentary

" tabularize

nmap <leader>T :Tabularize<space>
vmap <leader>T :Tabularize<space>

" CTAGS
" Rebuild tags
if filereadable('.ctags')
  nmap <leader>ct :!ctags&<cr><cr>
else
  nmap <leader>ct :!ctags -R .&<cr><cr>
end
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

" Select all text in the buffer
map <leader>sa ggVG

" Show git log for the current file
nmap <leader>gl :Git log -p %<cr>

" Show tig
nmap <silent>ti :!tig status<cr>

" Lusty juggler
let g:LustyJugglerKeyboardLayout = "colemak"
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
let g:ctrlp_max_height = 20
let g:ctrlp_jump_to_buffer = 1 " switch to already opened buffer
let g:ctrlp_working_path_mode = 0
let g:ctrlp_open_new_file = 3 " open in current window
let g:ctrlp_extensions = ['tag']
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_map = '<leader>mf'
" let g:ctrlp_user_command = {
"   \ 'types': {
"     \ 1: ['.git', 'cd %s && git ls-files'],
"     \ 2: ['.hg', 'hg --cwd %s locate -I .'],
"     \ },
"   \ 'fallback': ''
"   \ }
nmap <silent> <leader>mF :ClearCtrlPCache<cr>:CtrlP<cr>
nmap <silent> <leader>mb :CtrlPBuffer<cr>
nmap <silent> <leader>t :CtrlPTag<cr>

" parameter text objects
let g:no_parameter_object_maps = 1
vmap     <silent> i, <Plug>ParameterObjectI
omap     <silent> i, <Plug>ParameterObjectI
vmap     <silent> a, <Plug>ParameterObjectA
omap     <silent> a, <Plug>ParameterObjectA

" Redraw
nmap <leader>rr :redraw!<cr>

" Filetype detection extensions
au BufNewFile,BufRead *vimperatorrc*,*.vimp set filetype=vimperator
au BufNewFile,BufRead *.twig set filetype=twig
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.rc set filetype=conf
au BufNewFile,BufRead *.muttrc set filetype=muttrc

" Filesystem
nmap <leader>mk :!mkdir -p <c-r>=expand("%:p:h")."/"<cr>
nmap <leader>rm :!rm -rf <c-r>=expand("%:p:h")."/"<cr>

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

" Source user settings
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" Source project settings
if filereadable('.vimrc.local')
  source .vimrc.local
endif

" Translate the content of selection
" Classy.
vmap <leader>ee :s/\n/ /e<cr>:s/\./;/e<cr><esc>0vLhy"=system('google-translate fr en ' . shellescape("<C-R>""))<cr>p:s/​//e<cr>:s/;/./e<cr>:nohl<cr>o<esc>

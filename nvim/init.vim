" Vim configuration - Thibault Duplessis.

" vim-plug
call plug#begin(stdpath('data') . '/plugged')
" Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf.vim'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'codeindulgence/vim-tig'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/vim-lightline-coc'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-vinegar'
Plug 'chiel92/vim-autoformat'
Plug 'tpope/vim-commentary'
call plug#end()

let g:mapleader = ","

" === Theme ===

set termguicolors
syntax on
let g:onedark_terminal_italics=1
colorscheme onedark

" === Basic settings ===

set autoread                      " Automatically read a file that has changed on disk

set clipboard=unnamedplus         " Alias unnamed register to the + register, which is the X Window clipboard.

set history=9000                  " Sets how many lines of history VIM has to remember

set undolevels=2000               " use many levels of undo
set undofile                      " persistent

set noshowmode                    " Do not show mode on command line since lightline can show it

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

" === Plug lightline ===

let g:lightline = {
  \   'colorscheme': 'onedark',
  \   'active': {
  \     'left': [
  \       [ 'mode', 'paste' ], 
  \       [ 'coc_errors', 'coc_warnings', 'coc_ok' ],
  \       [ 'coc_status'  ], 
  \       [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
  \   'component_function': {
  \     'gitbranch': 'FugitiveHead'
  \   },
  \ }

" register compoments:
call lightline#coc#register()

" === Plug mzf ===

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

nnoremap <leader>ms :<C-u>GFiles<cr>
nnoremap <leader>mf :<C-u>Files<cr>
nnoremap <leader>mt :Buffers<cr>
nnoremap <leader>mr :Rg<cr>
nnoremap <leader>ma mA:Rg <C-r>=expand("<cword>")<cr><cr>
nnoremap <leader>md :b#<cr>               " Previous buffer

let g:fzf_tags_command = 'ctags --recurse --options=.ctags'

" === Plug Tig ===

nmap ti :Tig<cr>

" === Plug Coc ===

set updatetime=300
set signcolumn=yes

au BufRead,BufNewFile *.sbt,*.sc set filetype=scala

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Used in the tab autocompletion for coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Used to expand decorations in worksheets
nmap <Leader>ws <Plug>(coc-metals-expand-decoration)

" Use K to either doHover or show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region (???)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType scala setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of current line
xmap <leader>a  <Plug>(coc-codeaction-line)
nmap <leader>a  <Plug>(coc-codeaction-line)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Trigger for code actions
" Make sure `"codeLens.enable": true` is set in your coc config
nnoremap <leader>cl :<C-u>call CocActionAsync('codeLensAction')<CR>

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Notify coc.nvim that <enter> has been pressed.
" Currently used for the formatOnType feature.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Toggle panel with Tree Views
nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
" Toggle Tree View 'metalsPackages'
nnoremap <silent> <space>tp :<C-u>CocCommand metals.tvp metalsPackages<CR>
" Toggle Tree View 'metalsCompile'
nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" Toggle Tree View 'metalsBuild'
nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" Reveal current current class (trait or object) in Tree View 'metalsPackages'
nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsPackages<CR>

" === autoformat ===

" au BufWrite * :Autoformat

nmap <leader>i <Esc>:Autoformat<cr>:w<cr>

" === commentary ===

nmap <leader>c<space> <Plug>CommentaryLine
vmap <leader>c<space> <Plug>Commentary

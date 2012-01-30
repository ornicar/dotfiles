" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

"
" From builtin vim php ftplugin
"
setlocal commentstring=/*%s*/
if exists('&omnifunc')
  setlocal omnifunc=phpcomplete#CompletePHP
endif
" Section jumping: [[ and ]] provided by Antony Scriven <adscriven at gmail dot com>
let s:function = '\(abstract\s\+\|final\s\+\|private\s\+\|protected\s\+\|public\s\+\|static\s\+\)*function'
let s:class = '\(abstract\s\+\|final\s\+\)*class'
let s:interface = 'interface'
let s:section = '\(.*\%#\)\@!\_^\s*\zs\('.s:function.'\|'.s:class.'\|'.s:interface.'\)'
exe 'nno <buffer> <silent> [[ ?' . escape(s:section, '|') . '?<CR>:nohls<CR>'
exe 'nno <buffer> <silent> ]] /' . escape(s:section, '|') . '/<CR>:nohls<CR>'
exe 'ono <buffer> <silent> [[ ?' . escape(s:section, '|') . '?<CR>:nohls<CR>'
exe 'ono <buffer> <silent> ]] /' . escape(s:section, '|') . '/<CR>:nohls<CR>'
"
" END from builtin vim php ftplugin
"

" Use php man http://bjori.blogspot.com/search/label/vim
setlocal keywordprg=pman

" Use errorformat for parsing PHP error output
setlocal errorformat=%m\ in\ %f\ on\ line\ %l
"
" Configure tabstyle...
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" Because I write this shit so often
imap <buffer> <unique> ` ->
imap <buffer> <unique> <C-j> $this->

" Autoclose brackets
imap <buffer> <unique> {<cr> {<cr>}<esc>O

" Insert current class name
nmap <buffer> <unique> <leader>pcn "%pdF.xBdf/:s#/#\\#<CR>

" Replace namespace and class name based on filename
nmap <buffer> <unique> <leader>pn gg/namespace <CR>D"%PdF/r;:s#/#\\#<CR>Inamespace  <ESC>d/[A-Z]<CR>/class <CR>wcw<C-R>=expand("%:t:r")<CR><ESC>

" Insert current namespace and opens php and create empty class
nmap <buffer> <unique> <leader>pc ggO<?php<CR><CR><ESC>"%PdF/r;:s#/#\\#<CR>Inamespace  <ESC>d/[A-Z]<CR>Goclass <C-R>=expand("%:t:r")<CR><CR>{<CR>

" Public version:
" Insert current namespace and opens php and create empty class
"nmap <F9> ggO<?php<CR><CR><ESC>"%PdF/r;:s#/#\\#g<CR>Inamespace  <ESC>d/[A-Z]<CR>Goclass <C-R>=expand("%:t:r")<CR><CR>{<CR>

" Insert use statements based on ctags
map <buffer> <unique> <leader>pu :call PhpInsertUse()<CR>
" The same on insert mode
imap <buffer> <unique> <C-e>u <esc>:call PhpInsertUse()<CR>a

" Single line mode documentation
nnoremap <buffer> <unique> <leader>pd :call PhpDocSingle()<CR>

" Multi line mode documentation (in visual mode)
vnoremap <buffer> <unique> <leader>pd :call PhpDocRange()<CR>

" Align selected code
vnoremap <buffer> <unique> <leader>pa :call PhpAlign()<CR>
noremap <buffer> <unique> <leader>p{ vi{:call PhpAlign()<CR>
noremap <buffer> <unique> <leader>p} vi}:call PhpAlign()<CR>
noremap <buffer> <unique> <leader>p( vi(:call PhpAlign()<CR>
noremap <buffer> <unique> <leader>p) vi):call PhpAlign()<CR>

let g:pdv_cfg_Author = "Thibault Duplessis <thibault.duplessis@gmail.com>"
let g:pdv_cfg_License = "MIT {@link http://opensource.org/licenses/mit-license.html}"
let g:pdv_cfg_Copyright = "2011"
let g:pdv_cfg_php4always = 0 " Ignore PHP4 tags
" Wether to create @uses tags for implementation of interfaces and inheritance
let g:pdv_cfg_Uses = 0
" Wether for PHP5 code PHP4 tags should be set, like @access,... (1|0)?
let g:pdv_cfg_php4always = 0
" Wether to guess scopes after PEAR coding standards:
" $_foo/_bar() == <private|protected> (1|0)?
let g:pdv_cfg_php4guess = 0

func! PhpAlign() range
    let l:paste = &g:paste
    let &g:paste = 0

    let l:line        = a:firstline
    let l:endline     = a:lastline
    let l:maxlength = 0
    while l:line <= l:endline
		" Skip comment lines
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:line = l:line + 1
			continue
		endif
		" \{-\} matches ungreed *
        let l:index = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\S\{0,1}=\S\{0,1\}\s.*$', '\1', "")
        let l:indexlength = strlen (l:index)
        let l:maxlength = l:indexlength > l:maxlength ? l:indexlength : l:maxlength
        let l:line = l:line + 1
    endwhile

	let l:line = a:firstline
	let l:format = "%s%-" . l:maxlength . "s %s %s"

	while l:line <= l:endline
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:line = l:line + 1
			continue
		endif
        let l:linestart = substitute (getline (l:line), '^\(\s*\).*', '\1', "")
        let l:linekey   = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\1', "")
        let l:linesep   = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\2', "")
        let l:linevalue = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\3', "")

        let l:newline = printf (l:format, l:linestart, l:linekey, l:linesep, l:linevalue)
        call setline (l:line, l:newline)
        let l:line = l:line + 1
    endwhile
    let &g:paste = l:paste
endfunc

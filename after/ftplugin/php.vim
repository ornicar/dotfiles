" Only do this when not done yet for this buffer                                                                                                             
if exists("b:php_ftplugin_loaded")
    finish
endif
let b:php_ftplugin_loaded = 1

let PHP_autoformatcomment = 1

let php_sql_query = 1 "Coloration des requetes SQL
let php_htmlInStrings = 1 "Coloration des balises HTML

" Because I write it so often
imap ² ->

"Folding
nmap <buffer> <F5> <Esc>:EnableFastPHPFolds<Cr>
nmap <buffer> <C-F5> <Esc>:EnablePHPFolds<Cr>
nmap <buffer> <F6> <Esc>:DisablePHPFolds<Cr>
let g:DisableAutoPHPFolding = 1

" Indent PHP templates as HTML files
nmap <leader>= :set ft=html<cr>mhgg=G'h:set ft=php<cr>
" Indent whole PHP file
nmap <leader>i <Esc>mygg=G'y

" Use errorformat for parsing PHP error output
setlocal errorformat=%m\ in\ %f\ on\ line\ %l

" Use pman for manual pages
setlocal keywordprg=pman

" }}} Settings

" {{{ Command mappings

" Map <ctrl>+p to single line mode documentation (in insert and command mode)
inoremap <buffer> <C-P> :call PhpDocSingle()<CR>i
nnoremap <buffer> <C-P> :call PhpDocSingle()<CR>
" Map <ctrl>+p to multi line mode documentation (in visual mode)
vnoremap <buffer> <C-P> :call PhpDocRange()<CR>

" Map <CTRL>-H to search phpm for the function name currently under the cursor (insert mode only)
inoremap <buffer> <C-H> <ESC>:!phpm <C-R>=expand("<cword>")<CR><CR>

" Map <CTRL>-a to alignment function
vnoremap <buffer> <C-a> :call PhpAlign()<CR>

" {{{ Automatic close char mapping

" More common in PEAR coding standard
" inoremap <buffer>  { {<CR>}<C-O>O
" Maybe this way in other coding standards
"inoremap  { {<CR>}<C-O>O

" }}} Automatic close char mapping

let g:pdv_cfg_Author = "Thibault Duplessis <thibault.duplessis@gmail.com>"
let g:pdv_cfg_License = "MIT {@link http://opensource.org/licenses/mit-license.html}"
let g:pdv_cfg_Copyright = "2010"
let g:pdv_cfg_php4always = 0 " Ignore PHP4 tags

" {{{ Alignment

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

" }}}   

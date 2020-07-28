" === Util functions ===

" create file with subdirectories if needed :E
if !exists("g:E_loaded")
  let g:E_loaded = 1
  function s:MKDir(...)
    if         !a:0
          \|| stridx('`+', a:1[0])!=-1
          \|| a:1=~#'\v\\@<![ *?[%#]'
          \|| isdirectory(a:1)
          \|| filereadable(a:1)
          \|| isdirectory(fnamemodify(a:1, ':p:h'))
      return
    endif
    return mkdir(fnamemodify(a:1, ':p:h'), 'p')
  endfunction
  command -bang -bar -nargs=? -complete=file E :call s:MKDir(<f-args>) | e<bang> <args>
endif

" Processing results in quickfix http://efiquest.org/2009-02-19/32/
com! -nargs=1 Qfdo try | sil cfirst |
      \ while 1 | exec <q-args> | sil cn | endwhile |
    \ catch /^Vim\%((\a\+)\)\=:E\%(553\|42\):/ |
    \ endtry
com! -nargs=1 Qfdofile try | sil cfirst |
      \ while 1 | exec <q-args> | sil cnf | endwhile |
    \ catch /^Vim\%((\a\+)\)\=:E\%(553\|42\):/ |
    \ endtry

" Rename buffer and file
command! -nargs=* -complete=file -bang Rename :call Rename("<args>", "<bang>")
function! Rename(name, bang)
    let l:curfile = expand("%:p")
    let l:curfilepath = expand("%:p:h")
    let l:newname = l:curfilepath . "/" . a:name
    let v:errmsg = ""
    silent! exe "saveas" . a:bang . " " . l:newname
    if v:errmsg =~# '^$\|^E329'
        if expand("%:p") !=# l:curfile && filewritable(expand("%:p"))
            silent exe "bwipe! " . l:curfile
            if delete(l:curfile)
                echoerr "Could not delete " . l:curfile
            endif
        endif
    else
        echoerr v:errmsg
    endif
endfunction

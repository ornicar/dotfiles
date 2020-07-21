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

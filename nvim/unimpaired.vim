" Inspired by https://github.com/tpope/vim-unimpaired

function! s:BlankUp() abort
  put!=repeat(nr2char(10), 1)
endfunction

function! s:BlankDown() abort
  put =repeat(nr2char(10), 1)
endfunction

nmap [<space> :<C-U>call <SID>BlankUp()<CR>
nmap ]<space> :<C-U>call <SID>BlankDown()<CR>

nmap [q :<C-U>:cprev<CR>
nmap ]q :<C-U>:cnext<CR>

function! s:entries(path) abort
  let path = substitute(a:path,'[\\/]$','','')
  let files = split(glob(path."/.*"),"\n")
  let files += split(glob(path."/*"),"\n")
  call map(files,'substitute(v:val,"[\\/]$","","")')
  call filter(files,'v:val !~# "[\\\\/]\\.\\.\\=$"')

  let filter_suffixes = substitute(escape(&suffixes, '~.*$^'), ',', '$\\|', 'g') .'$'
  call filter(files, 'v:val !~# filter_suffixes')

  return files
endfunction

function! s:FileByOffset(num) abort
  let file = expand('%:p')
  if empty(file)
    let file = getcwd() . '/'
  endif
  let num = a:num
  while num
    let files = s:entries(fnamemodify(file,':h'))
    if a:num < 0
      call reverse(sort(filter(files,'v:val <# file')))
    else
      call sort(filter(files,'v:val ># file'))
    endif
    let temp = get(files,0,'')
    if empty(temp)
      let file = fnamemodify(file,':h')
    else
      let file = temp
      let found = 1
      while isdirectory(file)
        let files = s:entries(file)
        if empty(files)
          let found = 0
          break
        endif
        let file = files[num > 0 ? 0 : -1]
      endwhile
      let num += (num > 0 ? -1 : 1) * found
    endif
  endwhile
  return file
endfunction

function! s:fnameescape(file) abort
  if exists('*fnameescape')
    return fnameescape(a:file)
  else
    return escape(a:file," \t\n*?[{`$\\%#'\"|!<")
  endif
endfunction

nnoremap <silent> <Plug>unimpairedDirectoryNext     :<C-U>edit <C-R>=<SID>fnameescape(fnamemodify(<SID>FileByOffset(v:count1), ':.'))<CR><CR>
nnoremap <silent> <Plug>unimpairedDirectoryPrevious :<C-U>edit <C-R>=<SID>fnameescape(fnamemodify(<SID>FileByOffset(-v:count1), ':.'))<CR><CR>

nmap [f <Plug>unimpairedDirectoryNext
nmap ]f <Plug>unimpairedDirectoryNext

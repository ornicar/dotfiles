if exists('g:loaded_bufstop') 
  finish
endif

let g:loaded_bufstop = 1

let s:name = "--Bufstop--"
let s:lsoutput = ""
let s:types = ["fullname", "path", "shortname"]
let s:local_bufnr = -1
let s:fast_mode = 0
let s:speed_mounted = 0
let s:bufstop_mode_on = 0
let s:bufstop_mode_fast = 0
let s:use_statusline = 0
let s:frequency_map = {}

if !exists("g:BufstopSplit")
  let g:BufstopSplit = "botright"
endif

if !exists("g:BufstopSpeedKeys")
  let g:BufstopSpeedKeys = ["1", "2", "3", "4", "5", "6"]
endif

if !exists("g:BufstopLeader")
  let g:BufstopLeader = "<leader>"
endif

if !exists("g:BufstopModeNumFiles")
  let g:BufstopModeNumFiles = 8
endif

if !exists("g:BufstopAutoSpeedToggle")
  let g:BufstopAutoSpeedToggle = 0
endif

if !exists("g:BufstopDismissKey")
  let g:BufstopDismissKey = "<Esc>"
endif

if !exists("g:BufstopKeys")
  let g:BufstopKeys = "1234asfcvzx5qwertyuiopbnm67890ABCEFGHIJKLMNOPQRSTUVZ"
endif

if !exists("g:BufstopSorting")
  let g:BufstopSorting = "MRU"
endif

let s:keystr = g:BufstopKeys
let s:keys = split(s:keystr, '\zs')

let g:Bufstop_history = []

if has("syntax")
  hi def link bufstopKey String
  hi def link bufstopName Type
end

" truncate long file names
function! s:truncate(str, numfiles)
  let threshhold = 20
  if s:use_statusline
    let threshhold = winwidth(0) / a:numfiles
  else
    let threshhold = &columns / a:numfiles
  endif

  if strlen(a:str) + 3 >= threshhold
    let retval = strpart(a:str, 0, threshhold - 3)
    return retval
  else
    return a:str
  end
endfunction

" set properties for the Bufstop window
function! s:SetProperties()
  setlocal nonumber
  setlocal foldcolumn=0
  setlocal nofoldenable
  setlocal cursorline
  setlocal nospell
  setlocal nobuflisted
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal nowrap

  if has("syntax")
    syn match bufstopKey /\v^\s\s(\d|\a|\s)/ contained
    syn match bufstopName /\v^\s\s(\d|\a|\s)\s+.+\s\s/ contains=bufstopKey
  endif
endfunction

" select a buffer from the Bufstop window
function! s:BufstopSelectBuffer(k)
  let delkey = 0

  if (a:k == 'd')
    let delkey = 1
  endif

  let keyno = strridx(s:keystr, a:k) 
  let s:bufnr = -1

  let pos = 0
  if (keyno >= 0 && !delkey)
    for b in s:allbufs
      let pos += 1
      if b.key ==# a:k
        let s:bufnr = b.bufno
        break
      endif
    endfor
    " move cursor on the selected line
    exe pos
  else
    let s:bufnr = s:allbufs[line('.')-1].bufno
  endif

  if bufexists(s:bufnr)
    if delkey
      call remove(s:allbufs, line('.')-1)
      exe "silent bw ".s:bufnr
      setlocal modifiable
      exe "d"
      setlocal nomodifiable
    else
      exe "wincmd p"
      exe "silent b" s:bufnr
      exe "wincmd p"
      if s:fast_mode
        exe "q"
        exe "wincmd p"
      endif
    endif
  endif
endfunction

" create mappings for the Bufstop window
function! s:MapKeys()
  exe "nnoremap <buffer> <silent> " . g:BufstopDismissKey . " :q<cr><C-w>p"
  nnoremap <buffer> <silent> <cr>             :call <SID>BufstopSelectBuffer('cr')<cr>
  nnoremap <buffer> <silent> <2-LeftMouse>    :call <SID>BufstopSelectBuffer('cr')<cr>
  nnoremap <buffer> <silent> d                :call <SID>BufstopSelectBuffer('d')<cr>

  for buf in s:allbufs
    exe "nnoremap <buffer> <silent> ". buf.key. "   :call <SID>BufstopSelectBuffer('" . buf.key . "')<cr>"
  endfor
endfunction

function! BufstopGetBufferInfo()
    redir => s:lsoutput
    exe "silent ls"
    redir END

    return s:GetBufferInfo()
endfunction

" parse buffer list and get relevant info
function! s:GetBufferInfo()
  let s:allbufs = []
  let [s:allbufs, allwidths] = [[], {}]

  for n in s:types
    let allwidths[n] = []
  endfor
 
  let k = 0

  let bu_li = split(s:lsoutput, '\n')

  if g:BufstopSorting == "MRU"
    call sort(bu_li, "<SID>BufstopMRUCmp")
  elseif g:BufstopSorting == "MFU"
    call sort(bu_li, "<SID>BufstopMFUCmp")
  endif

  for buf in bu_li
    let bits = split(buf, '"')
    let b = {"attributes": bits[0], "line": substitute(bits[2], '\s*', '', '')} 
    
    let b.path = bits[1]
    let b.fullname = bits[1]
    let pathbits = split(bits[1], '\\\|\/', 1)
    let b.shortname = pathbits[len(pathbits)-1]
    let b.bufno = str2nr(bits[0])

    if (k < len(s:keys))
      let b.key = s:keys[k]
    else
      let b.key = 'X'
    endif

    let k = k + 1

    call add(s:allbufs, b)

    for n in s:types
      call add(allwidths[n], len(b[n]))
    endfor
  endfor

  let s:allpads = {}

  for n in s:types
    let s:allpads[n] = repeat(' ', max(allwidths[n]))
  endfor

  return s:allbufs
endfunction

" wrapper for Bufstop()
function! BufstopSlow()
  let s:fast_mode = 0
  call Bufstop()
endfunction

" wrapper for Bufstop()
function! BufstopFast()
  let s:fast_mode = 1
  call Bufstop()
endfunction

" main plugin entry point
function! Bufstop()
  let bufstop_winnr = bufwinnr(s:name)
  if bufstop_winnr != -1
    exe bufstop_winnr . "wincmd w"
    exe "q"
    return
  endif

  redir => s:lsoutput 
  exe "silent ls"
  redir END

  let lines = []
  let bufdata = s:GetBufferInfo()

  for buf in bufdata
    let line = ''
    if buf.key ==# 'X'
      let line = "  " . " " . "   "
    else
      let line = "  " . buf.key . "   "
    endif

    let path = buf["path"]
    let pad = s:allpads.shortname

    " let shortn = fnamemodify(buf.shortname, ":r")
    let line .= buf.shortname . "  " . strpart(pad . path, len(buf.shortname))
    
    call add(lines, line)
  endfor
  
  exe g:BufstopSplit . " " . min([len(lines), 20]) . " split"

  if s:local_bufnr < 0
    exe "silent e ".s:name
    let s:local_bufnr = bufnr(s:name)
  else
    exe "b ".s:local_bufnr
  endif
  
  setlocal modifiable
  exe 'setlocal statusline=Bufstop:\ ' . len(lines) . '\ buffers'
  " delete evertying in the buffer
  " (can't use 'normal ggdG' since the keys are remapped)
  exe 'goto'
  exe '%delete _'
  call setline(1, lines)
  " set cursor on the alternate buffer by default
  if len(lines) > 1
    exe 2
  endif
  setlocal nomodifiable

  call s:SetProperties()

  call s:MapKeys()
endfunction

" open the previous buffer in the navigation history for the current window.
function s:BufstopBack()
  if (!buflisted(winbufnr(winnr())))
    return
  endif

  if w:history_index > 0
    let w:history_index -= 1
    let bno = w:history[w:history_index]
    if (bufexists(bno) && buflisted(bno))
      execute "b " . bno
    else
      call map(w:history, 's:BufstopFilt(v:val, bno)')
      call s:BufstopBack()
    endif
  else
    " since we're here, do some cleanup
    call filter(w:history, 'v:val != -1')
    let w:history_index = 0
    call s:BufstopEcho("reached the bottom of window navigation history")
  endif
endfunction

" open the next buffer in the navigation history for the current window.
function! s:BufstopForward()
  if (!buflisted(winbufnr(winnr())))
    return
  endif

  if w:history_index < len(w:history) - 1
    let w:history_index += 1
    let bno = w:history[w:history_index]
    if (bufexists(bno) && buflisted(bno))
      execute "b " . bno
    else
      call map(w:history, 's:BufstopFilt(v:val, bno)')
      call s:BufstopForward()
    endif
  else
    " since we're here, do some cleanup
    call filter(w:history, 'v:val != -1')
    let w:history_index = len(w:history) - 1
    call s:BufstopEcho("reached the top of window navigation history")
  endif
endfunction

" callback for map function
function! s:BufstopFilt(val, bufnr)
  if (a:val == a:bufnr)
    return -1
  endif

  return a:val
endfunction

" add the buffer number to the navigation history for the window
function! s:BufstopAppend(bufnr)
    if !exists('w:history_index')
      let w:history_index = 0
      let w:history = []
    " ignore if the newly added buffer is the same as the previous active one
    elseif w:history[w:history_index] == a:bufnr
        return
    else
        let w:history_index += 1
    endif

    " replace the bufnr with -1 if it already exists
    call map(w:history, 's:BufstopFilt(v:val, a:bufnr)')

    let w:history = insert(w:history, a:bufnr, w:history_index)
endfunction

" add the buffer number to the global navigation history 
function! s:BufstopGlobalAppend(bufnr)
  if (!buflisted(a:bufnr))
    return
  endif
  call filter(g:Bufstop_history, 'v:val != '.a:bufnr) 
  call insert(g:Bufstop_history, a:bufnr)

  if !has_key(s:frequency_map, a:bufnr)
    let s:frequency_map[a:bufnr] = 1
  else
    let s:frequency_map[a:bufnr] += 1
  endif
endfunction

" echo a message in the Vim status line.
function! s:BufstopEcho(msg)
  echohl WarningMsg
  echomsg 'Bufstop: ' . a:msg
  echohl None
endfunction

" MRU compare callback
function! s:BufstopMRUCmp(line1, line2)
  let i1 = index(g:Bufstop_history, str2nr(a:line1))
  let i2 = index(g:Bufstop_history, str2nr(a:line2))
  " make sure the buffers that are not in history end up at the bottom
  if i1 == -1
    let i1 = len(g:Bufstop_history) + 1
  endif
  if i2 == -1
    let i2 = len(g:Bufstop_history) + 1
  endif

  return  i1 - i2
endfunction

" MFU compare callback
function! s:BufstopMFUCmp(line1, line2)
  let i1 = 0
  let i2 = 0

  if has_key(s:frequency_map, str2nr(a:line1))
    let i1 = s:frequency_map[str2nr(a:line1)]
  endif
  if has_key(s:frequency_map, str2nr(a:line2))
    let i2 = s:frequency_map[str2nr(a:line2)]
  endif

  return  i2 - i1
endfunction

" switch to a buffer in global history or ls output
function! BufstopSwitchTo(bufidx)
  call filter(g:Bufstop_history, "buflisted(v:val)")

  if a:bufidx >= len(g:Bufstop_history)
    if !exists("s:allbufs") || a:bufidx >= len(s:allbufs)
      call s:BufstopEcho("outside range")
      return
    else
      exe "b " . s:allbufs[a:bufidx].bufno
    endif
  else
    exe "b " . g:Bufstop_history[a:bufidx]
  endif
endfunction

" toggle speed commands
function! BufstopSpeedToggle()
  if s:speed_mounted
    call s:BufstopSpeedUnmount()
  else
    call s:BufstopSpeedMount()
  endif
endfunction

" mount mappings for speed commands
function! s:BufstopSpeedMount()
  if s:speed_mounted
    call s:BufstopEcho("speed mount already on")
    return
  endif

  let s:saved_speed_keys = []
  let idx = 0 
  for key in g:BufstopSpeedKeys
    let combo = g:BufstopLeader . key
    let maparg = maparg(combo)
    if (maparg !=# '')
      call add(s:saved_speed_keys, {'key': combo, 'mapping': maparg})
    endif

    exe "nmap <silent> " . combo . " " . ":call BufstopSwitchTo(" . idx . ")<CR>"
    let idx += 1
  endfor
  let s:speed_mounted = 1
endfunction

" unmout mappings for speed commands and restore the previous mappings
function! s:BufstopSpeedUnmount()
  if !s:speed_mounted
    call s:BufstopEcho("speed mount already off")
    return
  endif

  for key in g:BufstopSpeedKeys
    let combo = g:BufstopLeader . key
    exe "nunmap <silent> " . combo
  endfor

  let idx = 0
  for saving in s:saved_speed_keys
    exe "nmap <silent> " . saving.key . " " . saving.mapping
    let idx += 1
  endfor

  let s:speed_mounted = 0
endfunction

" statusline wrapper for BufstopMode
function! s:BufstopStatusline()
  let s:bufstop_mode_fast = 0
  let s:use_statusline = 1
  let s:old_statusline=&statusline
  call s:BufstopModeInit()
endfunction

" statusline fast wrapper for BufstopMode
function! s:BufstopStatuslineFast()
  let s:use_statusline = 1
  let s:bufstop_mode_fast = 1
  let s:old_statusline=&statusline
  call s:BufstopModeInit()
endfunction

" start BufstopMode and make it exit fast
function! s:BufstopModeFastStart()
  let s:bufstop_mode_fast = 1
  call s:BufstopModeInit()
endfunction

" start BufstopMode in preview mode
function! s:BufstopModeStart()
  let s:bufstop_mode_fast = 0
  call s:BufstopModeInit()
endfunction

" init and start BufstopMode
function! s:BufstopModeInit()
  let s:old_maxfuncdepth = &maxfuncdepth
  set maxfuncdepth=1000
  redraw

  call BufstopMode()
endfunction

" cleanup and exit BufstopMode
function! s:BufstopModeStop()
  " clear command line
  redraw
  echo ""

  let &maxfuncdepth = s:old_maxfuncdepth
  let s:bufstop_mode_fast = 0
  let s:bufstop_mode_on = 0
  if s:use_statusline
    let s:use_statusline = 0
    let &statusline = s:old_statusline
  endif
endfunction

" entry point for BufstopMode
function! BufstopMode()
  redir => s:lsoutput 
  exe "silent ls"
  redir END

  let line = ""
  let bufdata = s:GetBufferInfo()
  let bufdata = bufdata[0:g:BufstopModeNumFiles-1]

  " calculate initial length of line
  let line_len = 0
  for buffy in bufdata
    let line_len += strlen(buffy.shortname)
    let line_len += 3
  endfor

  let overflow = 0
  if s:use_statusline
    let overflow = winwidth(0)
  else
    let overflow = &columns
  endif

  let idx = 0
  let line = ""
  for buffy in bufdata
    let to_output = ""
    if line_len > overflow
      let to_output = s:truncate(buffy.shortname, len(bufdata))
    else
      let to_output = buffy.shortname
    endif

    echohl bufstopName
    echon " " . to_output
    let line = line . " " . to_output
    echohl None

    echon ":"
    let line .= ":"

    echohl bufstopKey
    echon s:keystr[idx]
    let line .= s:keystr[idx]
    echohl None

    let idx += 1
  endfor

  if s:use_statusline
    let &statusline = line . "%<"
    redraw
    echo "(Bufstop)"
  endif

  let code = getchar()
  let key = nr2char(code)
  if key == nr2char(27)
    let s:bufstop_mode_on = 0
    call s:BufstopModeStop()
    return
  else
    let s:bufstop_mode_on = 1
  endif

  let bufnr = 0
  for b in bufdata
    if b.key ==# key
      let bufnr = b.bufno
    endif
  endfor
  if bufexists(bufnr)
    exe "silent b" bufnr
  endif

  if !s:bufstop_mode_fast
    redraw
    call BufstopMode()
  endif

  call s:BufstopModeStop()
endfunction

function s:TimeoutFiddle(on_off)
  if a:on_off == 1
    let s:old_timeoutlen = &timeoutlen
    let &timeoutlen = 10
  else
    let &timeoutlen = s:old_timeoutlen
  end
endfunction

augroup Bufstop
  autocmd!
  autocmd BufEnter * :call s:BufstopAppend(winbufnr(winnr()))
  autocmd WinEnter * :call s:BufstopAppend(winbufnr(winnr()))
  autocmd BufWinEnter * :call s:BufstopGlobalAppend(expand('<abuf>') + 0)
  exe "autocmd BufWinEnter,WinEnter " . s:name . " :call s:TimeoutFiddle(1)"
  exe "autocmd BufWinLeave,WinLeave " . s:name . " :call s:TimeoutFiddle(0)"
augroup End

command! Bufstop :call BufstopSlow()
command! BufstopFast :call BufstopFast()
command! BufstopSpeedToggle :call BufstopSpeedToggle()
command! BufstopBack :call <SID>BufstopBack()
command! BufstopForward :call <SID>BufstopForward()
command! BufstopMode :call <SID>BufstopModeStart()
command! BufstopModeFast :call <SID>BufstopModeFastStart()
command! BufstopStatusline :call <SID>BufstopStatusline()
command! BufstopStatuslineFast :call <SID>BufstopStatuslineFast()

if g:BufstopAutoSpeedToggle
  call BufstopSpeedToggle()
endif


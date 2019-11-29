
" [error] /home/thib/lila/modules/common/src/main/WMMatching.scala:181: value class may not be a local class
" [error]     final class BlossomLeavesTraversable(b: Int) extends AnyVal {
" [error]                 ^
" [error] /home/thib/lila/modules/common/src/main/WMMatching.scala:181: value class parameter must be a val and not be private[this]
" [error]     final class BlossomLeavesTraversable(b: Int) extends AnyVal {
" [error]                                          ^
" set efm=%E\ %#[error]\ %#%f:%l:\ %m
" set efm+=%-Z\ %#[error]\ %p^
" set efm+=%-C\ %#[error]\ %m

" set efm+=%W\ %#[warn]\ %#%f:%l:\ %m
" set efm+=%-Z\ %#[warn]\ %p^
" set efm+=%-C\ %#[warn]\ %m

" set efm+=%-G%.%#

" [error] [E36] src/main/scala/io/prismic/SearchForm.scala
"       object jboss is not a member of package org
"       L75C33:           val encoder = new org.jboss.netty.handler.codec.http.QueryStringEncoder(form.action)
"                                               ^
" [error] [E35] src/main/scala/io/prismic/Document.scala
"       type mismatch;
"        found   : Seq[(String, io.prismic.Fragment)] (in scala.collection)
"        required: Seq[(?, ?)]                        (in scala.collection.immutable)
"        Note: implicit method reader is not applicable here because it comes after the application point and it lacks an explicit result type
"       L88C13:           }.flatten: _*
"
set efm=%E\ %#[error]\ %#[E%\\d%\\+]\ %f
set efm+=%C\ %#L%lC%c%.%#
set efm+=%-Z\ %#^%.%#
set efm+=%C\ %m

set efm+=%W\ %#[warn]\ %#[E%\\d%\\+]\ %f
set efm+=%C\ %#L%lC%c%.%#
set efm+=%-Z\ %#^%.%#
set efm+=%C\ %m

set efm+=%-G%.%#

let s:relativeQFLocation = "target/quickfix/sbt.quickfix"

function! sbtquickfix#LoadQuickFix()
  " Only works on *nixes
  let path = split(expand("%:p:h"), "/")
  let found = 0
  while !found && len(path) != 0
    let file = "/" . join(path, "/") . "/" . s:relativeQFLocation
    if filereadable(file)
      exec ":cf " . file
      return
    endif
    let path = path[0:-2]
  endwhile
  echoerr "Unable to locate quickfix file"
endfunction

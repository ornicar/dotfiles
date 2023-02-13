if exists("b:current_syntax")
  finish
endif

syn match routesRegexp "<[^>]\+>"
syn match routesParam  /[:*][A-Za-z0-9]\+/
syn match routesParam  /\($[A-Za-z0-9]\+\)<[^>]\+>/ contains=routesRegexp

syn include @scala syntax/scala.vim

syn region routesActionArgs matchgroup=routesAction start="(" end=")" contains=@scala contained oneline
syn region routesString start=+"+ end=+"+ oneline

syn keyword routesHttpMethod GET PUT PATCH POST DELETE HEAD OPTIONS contained
syn region routesMethod start="^" end=/\s/ contains=routesHttpMethod nextgroup=routesPath skipwhite oneline
syn region routesPath   start="/" end=/\s/ contains=routesParam nextgroup=routesAction skipwhite oneline
syn region routesAction start=/[a-zA-Z]\+\./ end="$" contains=routesActionArgs skipwhite oneline
syn match routesComment "#.*" contains=routesComment

if version >= 508 || !exists("did_play2routes_syn_inits")
  command -nargs=+ HiLink hi def link <args>
  HiLink routesHttpMethod Statement
  HiLink routesRegexp  Statement
  HiLink routesPath    Special
  HiLink routesAction  Underlined
  HiLink routesParam   Identifier
  HiLink routesComment Comment
  HiLink routesString  String
  delcommand HiLink
endif

let b:current_syntax = "play2-routes"

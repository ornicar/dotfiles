" http://www.pixelbeat.org/docs/terminal_colours/

hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "aldmeris255"
hi Normal ctermfg=252 ctermbg=none
hi Directory cterm=none ctermfg=51 ctermbg=none
hi ErrorMsg cterm=none ctermfg=231 ctermbg=196
hi IncSearch cterm=reverse ctermfg=none ctermbg=none
hi MoreMsg cterm=bold ctermfg=29 ctermbg=none
hi ModeMsg cterm=bold ctermfg=none ctermbg=none
hi Question cterm=bold ctermfg=46 ctermbg=none
hi StatusLine cterm=none ctermfg=244 ctermbg=233
hi StatusLineNC cterm=none ctermfg=242 ctermbg=235
hi LineNr ctermfg=238 ctermbg=233
hi VertSplit cterm=none ctermfg=238 ctermbg=238
hi Title cterm=bold ctermfg=201 ctermbg=none
hi WarningMsg cterm=none ctermfg=196 ctermbg=none
hi WildMenu cterm=none ctermfg=16 ctermbg=226
hi FoldColumn cterm=none ctermfg=51 ctermbg=250
hi DiffAdd cterm=none ctermfg=none ctermbg=18
hi DiffChange cterm=none ctermfg=none ctermbg=90
hi DiffDelete cterm=bold ctermfg=21 ctermbg=30
hi DiffText cterm=bold ctermfg=none ctermbg=196
hi SignColumn cterm=none ctermfg=51 ctermbg=250
hi SpellBad cterm=undercurl ctermfg=none ctermbg=196
hi SpellCap cterm=undercurl ctermfg=none ctermbg=21
hi SpellRare cterm=undercurl ctermfg=none ctermbg=201
hi SpellLocal cterm=undercurl ctermfg=none ctermbg=51
hi TabLine cterm=underline ctermfg=none ctermbg=248
hi TabLineSel cterm=bold ctermfg=none ctermbg=none
hi TabLineFill cterm=reverse ctermfg=none ctermbg=none
hi lCursor cterm=reverse ctermfg=none ctermbg=none
hi Cursor ctermfg=16 ctermbg=7
hi CursorLine cterm=none ctermfg=NONE ctermbg=233
hi CursorColumn ctermfg=NONE ctermbg=none
hi MatchParen cterm=bold ctermfg=208 ctermbg=none
hi Visual cterm=reverse ctermfg=none ctermbg=none
hi Folded ctermfg=251 ctermbg=NONE
hi NonText ctermfg=8 ctermbg=NONE
hi SpecialKey ctermfg=8 ctermbg=NONE
hi Pmenu ctermfg=250 ctermbg=234
hi PmenuSel ctermfg=231 ctermbg=8
hi PmenuSbar ctermfg=238 ctermbg=238
hi PmenuThumb ctermfg=102 ctermbg=102
hi Comment ctermfg=102 ctermbg=NONE
hi Constant ctermfg=11 ctermbg=NONE
hi String ctermfg=178 ctermbg=NONE
hi Boolean ctermfg=208 ctermbg=NONE
hi Number ctermfg=208 ctermbg=NONE
hi Float ctermfg=208 ctermbg=NONE
hi Identifier ctermfg=12 ctermbg=NONE
hi Function ctermfg=208 ctermbg=NONE
hi Class ctermfg=208 ctermbg=NONE
hi Statement cterm=bold ctermfg=254 ctermbg=NONE
hi PreProc ctermfg=13 ctermbg=NONE
hi Include ctermfg=208 ctermbg=NONE
hi Type cterm=none ctermfg=10 ctermbg=NONE
hi Special cterm=none ctermfg=208 ctermbg=NONE
hi Error cterm=bold ctermfg=15 ctermbg=1
hi Todo cterm=bold ctermfg=15 ctermbg=58
hi Search ctermbg=236 ctermfg=none
hi IncSearch cterm=reverse ctermbg=none ctermfg=none

hi link phpParent Comment
hi phpMemberSelector cterm=none ctermbg=none ctermfg=246

hi link phpMethodsVar Normal
hi link phpVarSelector Identifier
hi link phpIdentifier Identifier
hi link phpFunctions Function
hi link phpClasses Class
hi link phpSpecial Special
hi link phpBoolean Boolean
hi link phpNumber Number
hi link phpStringSingle String
hi link phpInclude Include
hi link phpStatement Statement
hi link phpOperator Comment

hi link xmlTag Identifier
hi link xmlEndTag Identifier
hi link xmlTagName Identifier
hi link xmlString String
hi link jinjaTagDelim Statement
hi link jinjaStatement Statement
hi link jinjaVarDelim jinjaTagDelim
hi link jinjaFilter Special
hi link jinjaString xmlString
hi link jinjaVarDelim Statement
hi link htmlString xmlString
hi link htmlSpecialChar PreProc
hi link htmlTag Normal
hi link htmlEndTag Normal
hi link htmlTagName Normal
hi link htmlH1 Normal
hi link htmlH2 Normal
hi link htmlH3 Normal
hi link htmlH4 Normal
hi link htmlH5 Normal
hi link htmlH6 Normal
hi link sqlKeyword String
hi link sqlStatement String

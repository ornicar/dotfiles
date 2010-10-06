if exists("g:moria_fontface")
    let s:moria_fontface = g:moria_fontface
else
    let s:moria_fontface = "plain"
endif

execute "command! -nargs=1 Colo let g:moria_style = \"<args>\" | colo moria"

set background=dark

hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "amonsul"

hi Normal ctermbg=Black ctermfg=LightGray guibg=#101010 guifg=#d0d0d0 gui=none

hi CursorColumn ctermbg=DarkGray ctermfg=White guibg=#404040 gui=none
hi CursorLine ctermbg=DarkGray ctermfg=White guibg=#202020 gui=none

hi FoldColumn ctermbg=bg guibg=bg guifg=#8fa5d1 gui=none
hi LineNr guifg=#8fa5d1 gui=none
hi MoreMsg guibg=bg guifg=#97abd5 gui=bold
hi NonText ctermfg=DarkGray guibg=bg guifg=#8fa5d1 gui=bold
hi Pmenu guibg=#6381be guifg=#000000 gui=none
hi PmenuSbar guibg=#41609e guifg=fg gui=none
hi PmenuThumb guibg=#bdcae3 guifg=bg gui=none
hi SignColumn ctermbg=bg guibg=bg guifg=#8fa5d1 gui=none
hi StatusLine ctermbg=LightGray ctermfg=Black guibg=#334b7d guifg=fg gui=bold
hi StatusLineNC ctermbg=DarkGray ctermfg=Black guibg=#25365a guifg=fg gui=none
hi TabLine guibg=#41609e guifg=fg gui=underline
hi TabLineFill guibg=#41609e guifg=fg gui=underline
hi VertSplit ctermbg=LightGray ctermfg=Black guibg=#25365a guifg=fg gui=none
if s:moria_fontface == "mixed"
    hi Folded guibg=#4e4e4e guifg=#bdcae3 gui=bold
else
    hi Folded guibg=#4e4e4e guifg=#bdcae3 gui=none
endif            

hi Cursor guibg=#ffa500 guifg=bg gui=none
hi DiffAdd guibg=#008b00 guifg=fg gui=none
hi DiffChange guibg=#00008b guifg=fg gui=none
hi DiffDelete guibg=#8b0000 guifg=fg gui=none
hi DiffText guibg=#0000cd guifg=fg gui=bold
hi Directory guibg=bg guifg=#1e90ff gui=none
hi ErrorMsg guibg=#ee2c2c guifg=#ffffff gui=bold
hi IncSearch guibg=#e0cd78 guifg=#000000 gui=none
hi ModeMsg guibg=bg guifg=fg gui=bold
hi PmenuSel guibg=#e0e000 guifg=#000000 gui=none
hi Question guibg=bg guifg=#e8b87e gui=bold
hi Search guibg=#90e090 guifg=#000000 gui=none
hi SpecialKey guibg=bg guifg=#e8b87e gui=none
if has("spell")
    hi SpellBad guisp=#ee2c2c gui=undercurl
    hi SpellCap guisp=#2c2cee gui=undercurl
    hi SpellLocal guisp=#2ceeee gui=undercurl
    hi SpellRare guisp=#ee2cee gui=undercurl
endif
hi TabLineSel guibg=bg guifg=fg gui=bold
hi Title ctermbg=Black ctermfg=White guifg=fg gui=bold
if version >= 700
    hi Visual ctermbg=LightGray ctermfg=Black guibg=#606060 gui=none
else
    hi Visual ctermbg=LightGray ctermfg=Black guibg=#606060 guifg=fg gui=none
endif
hi VisualNOS ctermbg=DarkGray ctermfg=Black guibg=bg guifg=#a0a0a0 gui=bold,underline
hi WarningMsg guibg=bg guifg=#ee2c2c gui=bold
hi WildMenu guibg=#e0e000 guifg=#000000 gui=bold

hi Comment guibg=bg guifg=#d0d0a0 gui=none
hi Constant guibg=bg guifg=#87df71 gui=none
hi Error guibg=bg guifg=#ee2c2c gui=none
hi Identifier guibg=bg guifg=#7ee0ce gui=none
hi Ignore guibg=bg guifg=bg gui=none
hi lCursor guibg=#00e700 guifg=#000000 gui=none
hi MatchParen guibg=#008b8b gui=none
hi PreProc guibg=bg guifg=#d7a0d7 gui=none
hi Special guibg=bg guifg=#e8b87e gui=none
hi Todo guibg=#e0e000 guifg=#000000 gui=none
hi Underlined ctermbg=Black ctermfg=White guibg=bg guifg=#00a0ff gui=underline    

if s:moria_fontface == "mixed"
    hi Statement guibg=bg guifg=#7ec0ee gui=bold
    hi Type guibg=bg guifg=#f09479 gui=bold
else
    hi Statement guibg=bg guifg=#7ec0ee gui=none
    hi Type guibg=bg guifg=#f09479 gui=none
endif

hi htmlBold ctermbg=Black ctermfg=White guibg=bg guifg=fg gui=bold
hi htmlBoldItalic ctermbg=Black ctermfg=White guibg=bg guifg=fg gui=bold,italic
hi htmlBoldUnderline ctermbg=Black ctermfg=White guibg=bg guifg=fg gui=bold,underline
hi htmlBoldUnderlineItalic ctermbg=Black ctermfg=White guibg=bg guifg=fg gui=bold,underline,italic
hi htmlItalic ctermbg=Black ctermfg=White guibg=bg guifg=fg gui=italic
hi htmlUnderline ctermbg=Black ctermfg=White guibg=bg guifg=fg gui=underline
hi htmlUnderlineItalic ctermbg=Black ctermfg=White guibg=bg guifg=fg gui=underline,italic

hi! default link bbcodeBold htmlBold
hi! default link bbcodeBoldItalic htmlBoldItalic
hi! default link bbcodeBoldItalicUnderline htmlBoldUnderlineItalic
hi! default link bbcodeBoldUnderline htmlBoldUnderline
hi! default link bbcodeItalic htmlItalic
hi! default link bbcodeItalicUnderline htmlUnderlineItalic
hi! default link bbcodeUnderline htmlUnderline

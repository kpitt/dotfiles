" Vim color file
" Maintainer:   Kenny Pitt <kenny.pitt@gmail.com>
" Last Change:  21 Aug 2007
" URL:		

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

" your pick:
set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="vibrant_ink"

highlight Normal guifg=White   guibg=Black
highlight Cursor guifg=Black   guibg=Yellow
highlight Keyword guifg=#FF6600
highlight Define guifg=#FF6600
highlight Comment guifg=#9933CC
highlight Type guifg=White gui=NONE
highlight rubySymbol guifg=#339999 gui=NONE
highlight Identifier guifg=White gui=NONE
highlight rubyStringDelimiter guifg=#66FF00
highlight rubyInterpolation guifg=White
highlight rubyPseudoVariable guifg=#339999
highlight Constant guifg=#FFEE98
highlight Function guifg=#FFCC00 gui=NONE
highlight Include guifg=#FFCC00 gui=NONE
highlight Statement guifg=#FF6600 gui=NONE
highlight String guifg=#66FF00
highlight Search guibg=White

" Uncomment and complete the commands you want to change from the default.

"hi CursorIM	
"hi Directory	
"hi DiffAdd		
"hi DiffChange	
"hi DiffDelete	
"hi DiffText	
"hi ErrorMsg	
"hi VertSplit	
"hi Folded		
"hi FoldColumn	
"hi IncSearch	
"hi LineNr		
"hi ModeMsg		
"hi MoreMsg		
"hi NonText		
"hi Question	
"hi SpecialKey	
"hi StatusLine	
"hi StatusLineNC	
"hi Title		
"hi Visual		
"hi VisualNOS	
"hi WarningMsg	
"hi WildMenu	
"hi Menu		
"hi Scrollbar	
"hi Tooltip		

" syntax highlighting groups
"hi Constant	
"hi PreProc	
"hi Special	
"hi Underlined	
"hi Ignore		
"hi Error		
"hi Todo		


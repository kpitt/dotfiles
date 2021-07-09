" Vim syntax file
" Language: Fortify SCA NST
" Authors:  Alvaro Munoz Sanchez, Kenny Pitt
" License:  MIT

if exists("b:current_syntax")
    finish
endif

" Comments
syntax match scaNstLineComment '//.*$'
syntax region scaNstBlockComment start='/\*' end='\*/' contains=scaNstLineComment

" Source info
syntax match scaNstColNum '#\d\+#\s\+' conceal " cchar=_

syntax match scaNstSourceInfo '#source-line\s\+\S\+'
syntax match scaNstSourceInfo '#source-file\s\+\S\+'
syntax match scaNstSourceInfo '#source-type\s\+\S\+'

" Directives
syntax match scaNstDirective '#NO-SOURCE-INF[O0]'
syntax match scaNstDirective '#\(END-\)\?TYPEDEF-DUMP'

" Operator
syntax match scaNstOperator ':[=.]:'
syntax match scaNstOperator /:\S\+:/
syntax match scaNstOperator /[-~]\+>/

" Method calls
" Old syntax
syntax match scaNstMethod /\~\~\zs[0-9a-zA-Z^$@]\+\ze\~/
syntax match scaNstClass /\(\~\|\s\)\zs[0-9a-zA-Z$]\+\ze\~\~/
" New syntax
syntax match scaNstMethod /\.\zs[0-9a-zA-Z^$@]\+\ze\~/
syntax match scaNstClass /\(\.\|\s\)\zs[0-9a-zA-Z$]\+\ze\.[0-9a-zA-Z^]\+\~/

" String
syntax region scaNstString start=/"/ skip=/\\"/ end=/"/

" Brackets 
syntax match scaNstBrackets /\[\s*\S\+\s*\]/

" Highlight Links
highlight def link scaNstNumber       Number 
highlight def link scaNstBrackets     SpecialChar
highlight def link scaNstString       String 
highlight def link scaNstLineComment  scaNstComment
highlight def link scaNstBlockComment scaNstComment
highlight def link scaNstComment      Comment
highlight def link scaNstMethod       Function 
highlight def link scaNstClass        Type 
highlight def link scaNstOperator     Operator
highlight def link scaNstDirective    PreProc
highlight def link scaNstSourceInfo   Comment
highlight def link scaNstColNum       Conceal

let b:current_syntax = "fortifynst"

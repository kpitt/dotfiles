" Vim syntax file
" Language: Fortify SCA NST
" Authors:  Alvaro Munoz Sanchez, Kenny Pitt
" License:  MIT

if exists("b:current_syntax")
    finish
endif

" Comments
syntax match nstLineComment '//.*$'
syntax region nstBlockComment start='/\*' end='\*/' contains=nstLineComment

" Source info
syntax match nstColNum '#\d\+#\s\+' conceal " cchar=_

syntax match nstSourceInfo '#source-line\s\+\S\+'
syntax match nstSourceInfo '#source-file\s\+\S\+'
syntax match nstSourceInfo '#source-type\s\+\S\+'

" Directives
syntax match nstDirective '#NO-SOURCE-INF[O0]'
syntax match nstDirective '#\(END-\)\?TYPEDEF-DUMP'

" Operator
syntax match nstOperator ':[=.]:'
syntax match nstOperator /:\S\+:/
syntax match nstOperator /[-~]\+>/

" Method calls
" Old syntax
syntax match nstMethod /\~\~\zs[0-9a-zA-Z^$@]\+\ze\~/
syntax match nstClass /\(\~\|\s\)\zs[0-9a-zA-Z$]\+\ze\~\~/
" New syntax
syntax match nstMethod /\.\zs[0-9a-zA-Z^$@]\+\ze\~/
syntax match nstClass /\(\.\|\s\)\zs[0-9a-zA-Z$]\+\ze\.[0-9a-zA-Z^]\+\~/

" String
syntax region nstString start=/"/ skip=/\\"/ end=/"/

" Brackets 
syntax match nstBrackets /\[\s*\S\+\s*\]/

" Highlight Links
highlight def link nstNumber       Number 
highlight def link nstBrackets     SpecialChar
highlight def link nstString       String 
highlight def link nstComment      Comment
highlight def link nstLineComment  nstComment
highlight def link nstBlockComment nstComment
highlight def link nstMethod       Function 
highlight def link nstClass        Type 
highlight def link nstOperator     Operator
highlight def link nstDirective    PreProc
highlight def link nstSourceInfo   Comment
highlight def link nstColNum       Conceal

let b:current_syntax = "fortifynst"

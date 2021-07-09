" Vim filetype plugin file
" Language: Fortify SCA NST
" Author:   Kenny Pitt
" License:  MIT

" Use single-line comments (useful with vim-commentary)
setl commentstring=//\ %s

" The `~` and `^` characters are common in NST identifiers, so add them to
" the keyword characters list.  Note that `^` must be last in the list so
" that it won't be interpreted as an exclude (see `:help isfname`).
setl iskeyword+=~,^

" Column number info makes the NST file much more difficult to read, so hide
" them by default.  In Insert mode, the column numbers will be shown for the
" line containing the cursor.
" Use command `:set cole=0` to always show the column numbers.
setl conceallevel=2
setl concealcursor=n

" Most NST files are generated with 4-space indents.
setl tabstop=4
setl softtabstop=4
setl shiftwidth=4

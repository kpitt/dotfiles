" Additional settings for Markdown files
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" Use <localleader>1/2/3 to add headings.
nnoremap <buffer> <localleader>1 yypVr=
nnoremap <buffer> <localleader>2 yypVr-
nnoremap <buffer> <localleader>3 I### <ESC>

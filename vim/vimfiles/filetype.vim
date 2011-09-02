" Additional file types
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect

" Textile
au BufNewFile,BufRead *.textile             setf textile

" RELAX NG Compact Syntax
au BufNewFile,BufRead *.rnc                 setf rnc

" ActionScript Syntax
au BufNewFile,BufRead *.as                  setf actionscript

augroup END

" Vim filetype plugin file
" Language:	Markdown

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

let b:undo_ftplugin = "ai< setl fo< com<"

setlocal ai

" Set 'formatoptions' to break all lines, insert the comment leader
" when hitting <CR> or using "o", and recognize numbered lists.
setlocal fo+=tcroqn fo-=l

" Set 'comments' to format dashed lists in comments.
setlocal comments=n:>

" Win32 can filter files in the browse dialog
if has("gui_win32") && !exists("b:browsefilter")
    let b:browsefilter = "Markdown Files (*.mkd)\t*.mkd\n" .
	  \ "All Files (*.*)\t*.*\n"
endif


" Vim settings for GUI only

" Set a default font list that should be installed on all machines...
set guifont=FiraCode-Regular:h12,MesloLGSNerdFontComplete:h12,HackNerdFontComplete-Regular:h12
" then add extra OS-specific fallbacks just in case.
if has("gui_gtk2")
    set guifont+=Monospace\ 9,DejaVu\ Sans\ Mono\ 9
elseif has("gui_macvim")
    set guifont+=Menlo-Regular:h12
else
    set guifont+=Consolas:h9,Andale_Mono:h8,Courier_New:h8
endif
set lines=56
set columns=120

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
set guioptions-=t

" I can't remember the last time I clicked anything on the toolbar, so just
" turn it off to save space.
set guioptions-=T

" Additional GUI-only airline options
let g:airline#extensions#tabline#enabled = 1

" vim:fdm=marker:fdl=1:

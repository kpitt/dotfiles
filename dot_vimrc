" Vim settings for all instances

" Change Leader to <Space>.  This needs to be set early because leader is used
" at the moment mappings are defined.  Changing it after a mapping is defined
" has no effect on the mapping.
let mapleader=' '

" Initialization "{{{
set nocompatible

execute pathogen#infect()
" }}}

" General options "{{{
set history=50		" keep 50 lines of command line history

behave mswin
set wildmenu
set wildmode=longest:full
"}}}
" Appearance options "{{{
set laststatus=2	" show status line all the time
set ruler		    " show the cursor position all the time
set cursorline      " highlight the current line
set statusline=%<%f%(\ %h%m%r%)\ %{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set showcmd		    " display incomplete commands
if winwidth(0) >= 80
    set number      " show line numbers unless window is unusually narrow
endif
syntax on           " syntax highlighting
colorscheme nord    " default terminal color scheme, can be overridden for GUI in gvimrc

" Airline configuration settings
set noshowmode      " only show mode in the airline status bar
let g:airline#extensions#tabline#enabled = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
"}}}
" Search options "{{{
set incsearch		" do incremental searching
set ignorecase      " use smart case-insensitivity
set smartcase
set hlsearch        " highlight the last used search pattern

" If ripgrep is available, use it as the grep prog.
" Otherwise, fall back to GNU grep.
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
else
    set grepprg=grep\ -nH
endif
"}}}
" File handling options "{{{
set nobackup		" do not keep a backup file

" Enable file type detection and language-dependent indenting.
filetype on
filetype plugin indent on

if !has('nvim')
    if !isdirectory($HOME.'/.local/share/vim/swap')
        silent call mkdir($HOME.'/.local/share/vim/swap', 'p')
    endif
    set dir=~/.local/share/vim/swap//
endif
"}}}

" Default file options "{{{
" (these can be overridden later for specific filetypes)
set autoindent		" always set autoindenting on
set tabstop=4       " I almost always use 4-space tabs
set softtabstop=4
set shiftwidth=4
set expandtab       " use spaces, not hard tabs
set smarttab        " use shiftwidth, not tabstop, at start of line
set shiftround      " always shift to a multiple of 'shiftwidth'
"}}}

" Keyboard mappings "{{{
" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Use Q for formatting the current paragraph or selection.
nmap Q gqap
vmap Q gq

" Move up/down by screen lines, not file lines.
nnoremap j gj
nnoremap k gk

" Clear the search highlighting.
nmap <silent> <leader>/ :nohlsearch<CR>

" Reselect the text that was just pasted.
nnoremap <leader>v V`]

" Quit current window on <leader>q.
nnoremap <leader>q :q<CR>

" Buffer switching.
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Quickfix navigation.
nnoremap <F2>    :cnext<CR>
nnoremap <S-F2>  :cprev<CR>
nnoremap <F3>    :cnfile<CR>
nnoremap <S-F3>  :cpfile<CR>

" Additional bindings for macOS only.
if has('osxdarwin')
    " Use C-K to format with `clang-format`
    " (this should probably be scoped to specific file types)
    map <C-K> :pyf ~/.vim/tools/clang-format.py<cr>
    imap <C-K> <c-o>:pyf ~/.vim/tools/clang-format.py<cr>
endif

" Plugin key mappings
nnoremap <C-p> :<C-u>Files<CR>
"}}}

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Diff Mode options "{{{
if &diff
    " Add a mapping to toggle the 'ignore whitespace' option.
    map gs :call IwhiteToggle()<CR>
    function! IwhiteToggle()
        if &diffopt =~ 'iwhite'
            set diffopt-=iwhite
        else
            set diffopt+=iwhite
        endif
    endfunction

    " Turn off cursorline highlighting because it hides line differences.
    set nocursorline
endif
"}}}

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" vim:foldmethod=marker:foldlevel=0

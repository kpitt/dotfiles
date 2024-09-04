" Vim-only key mappings (not loaded for Neovim)

" Clear the search highlighting.
nmap <silent> g/ :nohlsearch<CR>

" === Plugin key mappings ===

" Find files in current directory with FZF
nnoremap <silent> <C-p> :<C-u>Files<CR>
" Live grep files in current directory with FZF and RipGrep
nnoremap <silent> <leader>/ :<C-u>Rg<CR>

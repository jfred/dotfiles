map <Leader>p <C-^>

" Easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" Remap for history scrolling
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Hack to get C-h working in neovim
if has('nvim')
    nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
endif

" ctrl-l is normally mapped as redraw so now I redraw and window naviagte
nnoremap <C-l> <C-w>l:redraw!<CR>

" prevent falling back on bad habits
" unmap arrow keys
nmap <right> <nop>
nmap <left> <nop>
nmap <up> <nop>
nmap <down> <nop>
imap <right> <nop>
imap <left> <nop>
imap <up> <nop>
imap <down> <nop>


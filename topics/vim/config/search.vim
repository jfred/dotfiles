set incsearch         " do incremental searching
set nohlsearch        " turn off highlight searches, but:

" Turn hlsearch off/on with CTRL-N
map <silent> <C-N> :set invhlsearch<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" fzf commands
map <Leader>f :GFiles<CR>
map <Leader>F :Files<CR>
map <Leader>l :Lines<CR>
map <Leader>L :Rg<CR>
map <Leader>b :Buffers<CR>
map <Leader>t :Tags<CR>

" Use ag for search
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column -g'
  let g:unite_source_grep_recursive_opt = ''
endif

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

let g:unite_source_file_rec_ignore_pattern=
 \'\%(^\|/\)\.$\|\~$\|\.\%(o\|exe\|dll\|ba\?k\|sw[po]\|tmp\)$\|\%(^\|/\)\.\%(hg\|git\|bzr\|svn\|jruby\|idea\|vagrant\)\%($\|/\)\|node_modules'

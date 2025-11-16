" Python/Django specific configuration

" Python settings
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType python setlocal colorcolumn=120

" Django template syntax
autocmd BufNewFile,BufRead */templates/*.html setlocal filetype=htmldjango
autocmd BufNewFile,BufRead */templates/*.txt setlocal filetype=htmldjango

" Container execution prefix (configurable via environment)
" Set DOCKER_EXEC in your .envrc or shell:
"   export DOCKER_EXEC="docker-compose exec app"
"   export DOCKER_EXEC="docker exec -it mycontainer"
"   export DOCKER_EXEC=""  (for local development without containers)
let s:docker_exec = $DOCKER_EXEC
if s:docker_exec == ''
    " Default: no container wrapper (local development)
    let s:docker_exec = ''
else
    let s:docker_exec = s:docker_exec . ' '
endif

" Use terminal buffer for commands with scrollable output
" Opens in a horizontal split at bottom with max 20 lines
function! s:RunInTerminal(cmd)
    " Save current window
    let l:current_win = winnr()

    " Open terminal in bottom split
    botright 20split
    execute 'terminal ' . a:cmd

    " Set terminal buffer options
    setlocal nonumber norelativenumber
    setlocal scrolloff=0

    " Start in normal mode so you can scroll immediately
    normal! G

    " Return to original window (optional, comment out to stay in terminal)
    " execute l:current_win . 'wincmd w'
endfunction

" Python testing shortcuts (--noinput to avoid db prompts)
execute 'autocmd FileType python nnoremap <buffer> <Leader>tp :call <SID>RunInTerminal("' . s:docker_exec . 'python manage.py test --noinput")<CR>'
execute 'autocmd FileType python nnoremap <buffer> <Leader>tm :call <SID>RunInTerminal("' . s:docker_exec . 'python manage.py test --noinput " . expand("%"))<CR>'

" Django management commands
execute 'autocmd FileType python nnoremap <buffer> <Leader>dm :!' . s:docker_exec . 'python manage.py '
execute 'autocmd FileType python nnoremap <buffer> <Leader>ds :call <SID>RunInTerminal("' . s:docker_exec . 'python manage.py shell")<CR>'
execute 'autocmd FileType python nnoremap <buffer> <Leader>dr :call <SID>RunInTerminal("' . s:docker_exec . 'python manage.py runserver")<CR>'
execute 'autocmd FileType python nnoremap <buffer> <Leader>dd :call <SID>RunInTerminal("' . s:docker_exec . 'python manage.py migrate")<CR>'

" Format with black/ruff (these reload file, so use :! directly)
execute 'autocmd FileType python nnoremap <buffer> <Leader>fb :!' . s:docker_exec . 'black %<CR>:e<CR>'
execute 'autocmd FileType python nnoremap <buffer> <Leader>fr :!' . s:docker_exec . 'ruff check --fix %<CR>:e<CR>'

" ALE linting events
if g:has_async
    set updatetime=1000
    let g:ale_lint_on_text_changed = 0
    " autocmd CursorHold * call ale#Lint()
    " autocmd CursorHoldI * call ale#Lint()
    " autocmd InsertEnter * call ale#Lint()
    " autocmd InsertLeave * call ale#Lint()
endif

" commenting
map <Leader>/ :Commentary<CR>

" projectionist
map <Leader>,s :Esource<CR>
map <Leader>,t :Etest<CR>
map <Leader>,i :Eitest<CR>

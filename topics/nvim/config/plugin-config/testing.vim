" Vimux
let g:VimuxUseNearestPane = 1
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vc :VimuxCloseRunner<CR>

" vim-test
let test#strategy='vimux'
map <Leader>Tf :TestFile<CR>
map <Leader>Tn :TestNearest<CR>

map <Leader>u :call ToggleColor()<CR>

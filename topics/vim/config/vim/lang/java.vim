autocmd FileType java setlocal omnifunc=javacomplete#Complete
let g:JavaComplete_ShowExternalCommandsOutput=1
let test#java#runner = 'gradletest'

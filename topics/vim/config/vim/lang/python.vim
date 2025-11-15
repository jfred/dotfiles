" python - activate virtual env if present
if !empty($VIRTUAL_ENV) && filereadable($VIRTUAL_ENV . '/bin/python3')
  let g:python3_host_prog = $VIRTUAL_ENV . '/bin/python3'
endif

" preview rst
command Rst :silent !rst2html.py % > /tmp/rstprev.html && open /tmp/rstprev.html

" rope
"let g:ropevim_guess_project=1
"let g:ropevim_vim_completion=1
"let g:ropevim_extended_complete=1
"let ropevim_enable_shortcuts=1

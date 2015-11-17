" python - virtual env
if filereadable($VIRTUAL_ENV . '/bin/activate_this.py')
  python << EOF
  import os, sys
  sys.path.insert(0, os.environ['VIRTUAL_ENV'])
  activate_this = os.environ['VIRTUAL_ENV'] + '/bin/activate_this.py'
  execfile(activate_this, dict(__file__=activate_this))
  EOF
endif

" preview rst
command Rst :silent !rst2html.py % > /tmp/rstprev.html && open /tmp/rstprev.html

" rope
"let g:ropevim_guess_project=1
"let g:ropevim_vim_completion=1
"let g:ropevim_extended_complete=1
"let ropevim_enable_shortcuts=1

alias ls="ls -F --color=auto"
alias l="ls -lAh"
alias ll="ls -l"
alias la='ls -A'

alias ssh-add-all="find ~/.ssh -type f -name 'id_*' -not -name '*.pub' -execdir ssh-add -t 2h {} \;"

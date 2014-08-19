if [[ "$(uname)" = "Darwin" ]]; then
    alias tmux='tmux -f ~/.tmux_osx.conf'
fi
alias t='tmux attach || tmux'

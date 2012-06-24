autoload colors
colors

# bash style words
autoload -U select-word-style
select-word-style bash

bindkey -e

# term colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagacad

fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

setopt histignorealldups

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history


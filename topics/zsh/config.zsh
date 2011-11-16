autoload colors
colors

# bash style words
autoload -U select-word-style
select-word-style bash

# term colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagacad

fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

setopt histignorealldups

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

setopt promptsubst

# Load the prompt theme system
#autoload -U promptinit
#promptinit
# zgitinit and prompt_wunjo_setup must be somewhere in your $fpath, see README for more.
#prompt jfred

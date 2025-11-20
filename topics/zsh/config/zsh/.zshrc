zmodload zsh/datetime

# Override in ~/.localrc to disable modules
# The following example would disable java and vagrant
#     DOT_EXCLUDE='(java|vagrant)'
DOT_EXCLUDE='_no_matches_'

# load config and system specific
[[ -f ~/.localrc ]] && source ~/.localrc

export PATH=${PATH}:~/bin:${DOTFILES}/bin

if [[ $- == *i* ]]; then
    # threshold where config is configured slow
    WARN_THRESHOLD=1.0
    function source_config {
        local -i t0
        t0=$EPOCHREALTIME
        source ${1}
        runtime=$[EPOCHREALTIME-t0]
        [[ $runtime -gt $WARN_THRESHOLD ]] && echo "WARN sourcing $1 took ${runtime}s"
    }
else
    function source_config {
        source ${1}
    }
fi

# load all zsh and bin for enabled topics
for config_file (${DOTFILES}/**/*.zsh) do
    if [[ ! ${config_file} =~ ${DOT_EXCLUDE} ]]; then
        source_config ${config_file}
    fi
done
for bin (${DOTFILES}/**/bin); do
    if [[ ! ${bin} =~ ${DOT_EXCLUDE} ]]; then
        export PATH=${PATH}:${bin}
    fi
done

[ -n ${DOTFILES_POST_INIT+1} ] && eval ${DOTFILES_POST_INIT}

# Zsh configuration
autoload colors
colors

# bash style words
autoload -U select-word-style
select-word-style bash

bindkey -e

setopt +o nomatch
setopt extendedglob
setopt histignorealldups

# term colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagacad

export CDPATH=$CDPATH:$HOME:$HOME/Code

# History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history

# Ensure history directory exists
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h}

# History options
setopt appendhistory        # Append to history file
setopt sharehistory         # Share history between sessions
setopt incappendhistory     # Write to history file immediately

# Load zsh functions
fpath=(${ZDOTDIR}/functions $fpath)
autoload -U ${ZDOTDIR}/functions/*(:t)

# checking cached .zcompdump only once a day
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

# Initialize zoxide (smarter cd) if available - must be after compinit
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Starship prompt - initialize after /etc/zshrc
command -v starship &> /dev/null && eval "$(starship init zsh)"

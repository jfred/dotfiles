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

# Fix mise task completion with colons (e.g., dev:start) and add alias support
# usage-cli doesn't handle colons well - "dev:" and "dev:bac" return nothing
# but "dev" returns "dev:backend-shell" etc. So we strip everything after the
# last colon (or the trailing colon) for the lookup, then let compadd filter.
_mise() {
  if ! type -p usage &> /dev/null; then
    echo >&2 "Error: usage CLI not found. See https://usage.jdx.dev"
    return 1
  fi

  local spec_file="${TMPDIR:-/tmp}/usage__mise_spec_$(date +%Y_%m_%d).spec"
  if [[ ! -f "$spec_file" ]]; then
    mise usage > "$spec_file"
  fi

  # If current word contains a colon, strip from the last colon for usage lookup
  # e.g., "dev:" -> "dev", "dev:bac" -> "dev", "lint:format:ch" -> "lint:format"
  local -a query_words=("${words[@]}")
  local cur_word="${words[$CURRENT]}"
  if [[ "$cur_word" == *:* ]]; then
    query_words[$CURRENT]="${cur_word%:*}"
  fi

  # Get completions from usage and parse out the values
  local -a vals
  local line
  while IFS= read -r line; do
    # Extract value from 'value\:stuff'\:'description' format
    if [[ "$line" =~ "^'([^']*)'" ]]; then
      local val="${match[1]}"
      val="${val//\\\\:/:}"  # unescape \: to :
      vals+=("$val")
    fi
  done < <(command usage complete-word --shell zsh -f "$spec_file" -- "${query_words[@]}")

  # Add task aliases (usage-cli doesn't include them)
  # Only do this for task position (2nd word) to avoid slowdown elsewhere
  if [[ $CURRENT -eq 2 ]] && command -v jq &>/dev/null; then
    local -a aliases
    aliases=($(mise tasks --json 2>/dev/null | jq -r '.[].aliases[]?' 2>/dev/null))
    vals+=("${aliases[@]}")
  fi

  compadd -S '' -q "${vals[@]}"
  return 0
}
compdef _mise mise

# Starship prompt - initialize after /etc/zshrc
command -v starship &> /dev/null && eval "$(starship init zsh)"

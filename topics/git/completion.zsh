# Git completion configuration
# Ensure aliases and custom git-* commands are included in completion

# zstyle settings can be set before compinit
zstyle ':completion:*:*:git:*' tag-order 'common-commands alias-commands all-commands external-commands'
zstyle ':completion:*:*:git:*' verbose true

# Git alias completions - must be set up after compinit via precmd hook
# This ensures _git-switch and other completion functions are loaded
_setup_git_alias_completions() {
  # Only run once
  [[ -n $_git_alias_completions_done ]] && return
  _git_alias_completions_done=1

  # Remove this hook
  precmd_functions=(${precmd_functions:#_setup_git_alias_completions})

  # Map git aliases to their underlying command completions
  # sw -> switch (branch completion)
  __git-sw_main() { _git-switch "$@" }
}

# Register the setup to run once on first prompt (after compinit)
precmd_functions+=(_setup_git_alias_completions)

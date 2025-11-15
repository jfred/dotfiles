# Git completion configuration
# Ensure aliases and custom git-* commands are included in completion

# Make sure all command types are completed, including external commands:
# - common-commands: built-in git commands (checkout, commit, push, etc.)
# - alias-commands: git aliases from ~/.config/git/config
# - all-commands: all git commands including builtins
# - external-commands: custom git-* executables in PATH
zstyle ':completion:*:*:git:*' tag-order 'common-commands alias-commands all-commands external-commands'

# Enable verbose completion to show what each alias does
zstyle ':completion:*:*:git:*' verbose true

# Add custom external command completion
__git_zsh_cmd_external() {
  local -a external_commands
  # Get external git-* commands and add descriptions
  # Format: "command:description"
  local cmd
  for cmd in ${(f)"$(git --list-cmds=others 2>/dev/null)"}; do
    external_commands+=("$cmd:external git command")
  done
  _describe -t external-commands 'external commands' external_commands
}

# Hook into git completion if not already done
if [[ ! " ${(k)functions} " =~ " __git_zsh_cmd_external " ]]; then
  # Function is now defined above, this check prevents reloading
  :
fi

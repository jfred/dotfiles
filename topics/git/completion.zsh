# Git completion configuration
# Ensure aliases are included in git command completion

# Make sure alias-commands are completed alongside common-commands
zstyle ':completion:*:*:git:*' tag-order 'common-commands alias-commands'

# Enable verbose completion to show what each alias does
zstyle ':completion:*:*:git:*' verbose true

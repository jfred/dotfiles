# Use eza instead of ls when available, fallback to traditional ls
if command -v eza &> /dev/null; then
    alias ls='eza'
    alias l='eza -lah --git'
    alias ll='eza -l --git'
    alias la='eza -la --git'
    alias lt='eza -T'  # tree view
else
    alias ls="ls -F --color=auto"
    alias l="ls -lAh"
    alias ll="ls -l"
    alias la='ls -A'
fi

# Use bat instead of cat when available
if command -v bat &> /dev/null; then
    alias cat='bat --style=plain --paging=never'
    alias catt='bat --style=full'  # cat with full bat features
fi

# fd convenience alias for including hidden files
if command -v fd &> /dev/null; then
    alias fda='fd -H'
fi

alias dotfiles='${DOTFILES}/install.sh'

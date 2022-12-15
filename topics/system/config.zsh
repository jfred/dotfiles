# setting up dir colors
if [ -e ~/.dir_colors ]; then
    if type dircolors > /dev/null; then
        eval `dircolors ~/.dir_colors`
    fi
fi

# direnv if available
if type direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi

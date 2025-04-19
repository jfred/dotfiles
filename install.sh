#!/usr/bin/env bash

INTER=0

# ensure running from the right directory

HERE=`dirname $0`

# set exclude defaults
DOT_EXCLUDE="${DOT_EXCLUDE:-osx}"
DOT_INCLUDE="${DOT_INCLUDE}"
platform=$(uname -o 2> /dev/null || uname)
if [ -z "${DOT_EXCLUDE}" ]; then
    DOT_EXCLUDE="osx"
    if [[ ${platform} == 'Darwin' ]]
    then
        DOT_EXCLUDE="(linux|ubuntu)"
    fi
fi

# Check arguments using shift
while [[ $# -gt 0 ]]; do
    case "$1" in
        -i|--interactive)
            INTER=1
            ;;
        -h)
            echo "usage: $0 [-i|--interactive]"
            exit 0 ;;
        *)
            # Default case: set DOT_INCLUDE to the first argument
            DOT_INCLUDE="$1"
            ;;
    esac
    shift
done

# Override when in dev container to only install git
if [ -f /.dockerenv ]; then
    DOT_INCLUDE="git" 
fi

platform=$(uname -o 2> /dev/null || uname)

confirm(){
    echo -n "$* "
    read ans
    for res in y Y yes; do
        if [ "_${ans}" == "_${res}" ]; then
            return 0
        fi
    done
    return 1
}

# Function to check if a filename matches DOT_EXCLUDE
should_include() {
    local filename="$1"
    local result=1
    if [[ "${filename}" =~ ${DOT_EXCLUDE} ]]; then
        result=1
    elif [ -z "${DOT_INCLUDE}" ] || [[ "${filename}" =~ "/${DOT_INCLUDE}/" ]]; then
        result=0 # Filename is included or include pattern is empty
    fi
    return $result  # Filename is not included
}

mklink(){
    filename=$(echo "$1" | sed 's/\.\///')
    link_file="${HOME}/.$(echo "${filename}" | sed 's/.*\/\([a-z_.A-Z]*\).symlink/\1/')"
    orig_file="${filename}"
    # if the link already exists and pointing to the right place - continue
    if [ -L "${link_file}" ]; then
        target=$(readlink "${link_file}")
        if [ "${target}" == "${orig_file}" ]; then
            return 0
        fi
    fi

    if [ -e "${link_file}" ]; then
        if [ ${INTER} -eq 1 ]; then
            confirm "Replace ${link_file} with ${filename}? (y/N)"
            if [ $? -eq 1 ]; then
                return 1
            fi
        else
            echo "File ${link_file} already exists, skipping"
        fi
    elif [ ${INTER} -eq 1 ]; then
        confirm "Create link ${link_file}? (y/N)"
        if [ $? -eq 1 ]; then
            return 1
        fi
    fi
    echo ln -fs "${orig_file} ${link_file}"
    ln -fs "${orig_file}" "${link_file}"
    echo "${orig_file} linked as ${link_file}"
}

# Create base config
if [ ! -f ~/.localrc ]; then
    echo "Creating defaults"
    echo "export DOTFILES=$(pwd)" >> ~/.localrc
    if [[ ${platform} == 'Darwin' ]]
    then
        echo "source \${DOTFILES}/extras/osx/local_rc" >> ~/.localrc
    fi
    echo "export DOT_EXCLUDE='${DOT_EXCLUDE}'" >> ~/.localrc
fi

# Create links
LINKS=$(find ${HERE} -name '*.symlink')
for filename in ${LINKS}; do
    if should_include "${filename}"; then
        mklink "${filename}"
    fi
done

# Run installs
LINKS=$(find ${HERE}/topics -name 'install.sh')
for filename in ${LINKS}; do
    if should_include "${filename}"; then
        if [ ${INTER} -eq 1 ]; then
            confirm "Execute ${filename}? (y/N)"
            if [ $? -eq 0 ]; then
                echo -n "Executing ${filename}..."
                ${filename}
            fi
        else
            echo -n "Executing ${filename}..."
            ${filename}
        fi
    fi
done

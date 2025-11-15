#!/usr/bin/env bash

INTER=0

# ensure running from the right directory

# Get the absolute path of the script
HERE=`dirname $0`
HERE=`cd ${HERE} && pwd`

# set exclude defaults
DOT_EXCLUDE="${DOT_EXCLUDE}"
DOT_INCLUDE="${DOT_INCLUDE}"
platform=$(uname -o 2> /dev/null || uname)
if [ -z "${DOT_EXCLUDE}" ]; then
    DOT_EXCLUDE="osx"
    if [[ "${platform}" == 'Darwin' ]]
    then
        DOT_EXCLUDE="(linux|ubuntu)"
    fi
fi

echo "Running with:"
echo "   include: ${DOT_INCLUDE}"
echo "   exclude: ${DOT_EXCLUDE}"

# Check arguments using shift
while [[ $# -gt 0 ]]; do
    case "$1" in
        -i|--interactive)
            INTER=1
            ;;
        -h|--help)
            echo "usage: $0 [-i|--interactive] [topic]"
            echo ""
            echo "Options:"
            echo "  -i, --interactive    Confirm each step interactively"
            echo "  -h, --help          Show this help message"
            echo ""
            echo "Arguments:"
            echo "  topic               Install only the specified topic (e.g., git, vim, zsh)"
            echo ""
            echo "Environment Variables:"
            echo "  DOT_EXCLUDE         Regex pattern to exclude topics (e.g., '(java|vagrant)')"
            echo "  DOT_INCLUDE         Regex pattern to include topics (overridden by topic arg)"
            echo ""
            echo "Examples:"
            echo "  $0                  Install all topics (platform-aware)"
            echo "  $0 git              Install only git topic"
            echo "  $0 -i               Install all topics interactively"
            echo "  DOT_EXCLUDE='java' $0   Install all except java topic"
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
    local ans
    echo -n "$* " >&2
    read -r ans </dev/tty
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

mkxdglink(){
    local source_file="$1"
    # Extract the path after /config/
    # e.g., topics/git/config/git/config -> git/config
    local xdg_path=$(echo "${source_file}" | sed 's|.*/topics/[^/]*/config/||')
    local xdg_config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
    local link_file="${xdg_config_home}/${xdg_path}"
    local orig_file="${source_file}"

    # if the link already exists and pointing to the right place - continue
    if [ -L "${link_file}" ]; then
        target=$(readlink "${link_file}")
        if [ "${target}" == "${orig_file}" ]; then
            return 0
        fi
    fi

    if [ -e "${link_file}" ]; then
        if [ ${INTER} -eq 1 ]; then
            confirm "Replace ${link_file} with ${source_file}? (y/N)"
            if [ $? -eq 1 ]; then
                return 1
            fi
        else
            echo "File ${link_file} already exists, skipping"
            return 1
        fi
    elif [ ${INTER} -eq 1 ]; then
        confirm "Create link ${link_file}? (y/N)"
        if [ $? -eq 1 ]; then
            return 1
        fi
    fi

    # Create parent directory if needed
    local parent_dir=$(dirname "${link_file}")
    if [ ! -d "${parent_dir}" ]; then
        mkdir -p "${parent_dir}"
    fi

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

# Clean up broken symlinks that point to dotfiles repo
echo "Checking for broken symlinks..."
while IFS= read -r link; do
    # Check if the link is broken
    if [ ! -e "${link}" ]; then
        target=$(readlink "${link}")
        # Check if it points into our dotfiles directory
        if [[ "${target}" == *"/dotfiles/"* ]] || [[ "${target}" == *"${HERE}"* ]]; then
            if [ ${INTER} -eq 1 ]; then
                confirm "Remove broken symlink ${link} -> ${target}? (y/N)"
                if [ $? -eq 0 ]; then
                    rm "${link}"
                    echo "Removed broken symlink: ${link}"
                fi
            else
                echo "Found broken symlink: ${link} -> ${target}"
                echo "  Run with -i to interactively remove broken symlinks"
            fi
        fi
    fi
done < <(find "${HOME}" -maxdepth 1 -type l -name '.*' 2>/dev/null)
echo

# Create XDG config links (files in topics/*/config/)
XDG_FILES=$(find ${HERE}/topics -path '*/config/*' -type f)
for filename in ${XDG_FILES}; do
    if should_include "${filename}"; then
        mkxdglink "${filename}"
    fi
done

# Create traditional home directory symlinks (*.symlink files)
LINKS=$(find ${HERE} -name '*.symlink')
for filename in ${LINKS}; do
    if should_include "${filename}"; then
        mklink "${filename}"
    fi
done

# Run Brewfiles
if command -v brew &> /dev/null; then
    BREWFILES=$(find ${HERE}/topics -name 'Brewfile*')
    for filename in ${BREWFILES}; do
        if should_include "${filename}"; then
            if [ ${INTER} -eq 1 ]; then
                confirm "Run brew bundle for ${filename}? (y/N)"
                if [ $? -eq 0 ]; then
                    echo "Running brew bundle for ${filename}..."
                    brew bundle --file="${filename}"
                fi
            else
                echo "Running brew bundle for ${filename}..."
                brew bundle --file="${filename}"
            fi
        fi
    done
fi

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

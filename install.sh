#!/usr/bin/env bash
INTER=1
if [ ! "_$1" == "_" ]; then
    if [ "_$1" == "_-i" ]; then
        INTER=0
    fi
    if [ "_$1" == "_--interactive" ]; then
        INTER=0
    fi
    if [ "_$1" == "_-h" ]; then
        echo "usage: $0 [-i|--interactive]"
        exit 0
    fi
fi

platform=`uname -o 2> /dev/null || uname`
if [ -n "$DOT_EXCLUDE" ]; then
    DOT_EXCLUDE="osx"
    if [[ $platform == 'Darwin' ]]
    then
        DOT_EXCLUDE="(linux|ubuntu)"
    fi
fi

confirm(){
    echo -n "$@ "
    read ans
    for res in y Y yes; do
        if [ "_${ans}" == "_${res}" ]; then
            return 0
        fi
    done
    return 1
}

mklink(){
    filename=`echo $1 | sed 's/\.\///'`
    link_file="${HOME}/.`echo ${filename} | sed 's/.*\/\([a-z_.A-Z]*\).symlink/\1/'`"
    orig_file="`pwd`/${filename}"
    # if the link already exists and pointing to the right place - continue
    if [ -L $link_file ]; then
        target=`readlink ${link_file}`
        if [ "${target}" == "${orig_file}" ]; then
            return 0
        fi
    fi

    if [ -e $link_file ]; then
        confirm "Replace ${link_file}? (y/N)"
        if [ $? -eq 1 ]; then
            return 1
        fi
    elif [ ${INTER} -eq 0 ]; then
        confirm "Create link ${link_file}? (y/N)"
        if [ $? -eq 1 ]; then
            return 1
        fi
    fi
    echo ln -fs $orig_file $link_file
    ln -fs $orig_file $link_file
    echo "$orig_file linked as $link_file"
}

# Create base config
if [ ! -f ~/.localrc ]; then
    echo "Creating defaults"
    echo "export DOTFILES=`pwd`" >> ~/.localrc
    if [[ $platform == 'Darwin' ]]
    then
        echo "source $DOTFILES/extras/osx/local_rc" >> ~/.localrc
    fi
    echo "export DOT_EXCLUDE='${DOT_EXCLUDE}'" >> ~/.localrc
fi

# Create links
LINKS=`find . -name '*.symlink'`
for filename in ${LINKS}; do
    if [[ $filename =~ $DOT_EXCLUDE ]]; then
        # echo "Skipping ${filename}"
        continue
    fi
    mklink "$filename"
done

# Run installs
LINKS=`find topics -name 'install.sh'`
for filename in ${LINKS}; do
    if [[ $filename =~ $DOT_EXCLUDE ]]; then
        # echo "Skipping ${filename}"
        continue
    fi
    if [ ${INTER} -eq 0 ]; then
        confirm "Execute ${filename}? (y/N)"
        if [ $? -eq 0 ]; then
            ${filename}
        fi
    else
        ${filename}
    fi
done

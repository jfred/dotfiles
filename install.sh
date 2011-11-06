#!/usr/bin/env bash

git submodule init
git submodule update

if [ $1 ]; then
verbose() {
    echo $1
}
else
verbose(){
    echo $1 > /dev/null
}
fi

LINKS=`find . -d 1 ! -name '*.sh' ! -name '.git*' ! -name '*.markdown' ! -name 'extras' | sed 's/\.\///g'`
for filename in ${LINKS}; do
    temp_file="${HOME}/.${filename}"
    orig_file=`pwd`/${filename}
    if [ -L $temp_file ]; then
        verbose "${filename} - already a link"
    elif [ -e $temp_file ]; then
        echo "${filename} - already exists"
    else
        ln -s $orig_file $temp_file
        echo "$temp_file - linked"
    fi
done

#!/usr/bin/env bash
set -e

link(){
    filename=`echo $1 | sed 's/\.\///'`
    link_file="${HOME}/.`echo ${filename} | sed 's/.*\/\([a-zA-Z]*\).symlink/\1/'`"
    orig_file="`pwd`/${filename}"
    if [ -L $link_file ]; then
        echo "${filename} - already a link"
    elif [ -e $link_file ]; then
        echo "${filename} - already exists"
    else
        ln -s $orig_file $link_file
        echo "$orig_file linked as $link_file"
    fi
}

LINKS=`find . -name '*.symlink'`
for filename in ${LINKS}; do
    link "$filename"
done

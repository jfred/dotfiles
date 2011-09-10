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

IGNORE=('install.sh' 'Rakefile' 'README' 'LICENSE' 'localrc')
for filename in *; do
    ignores=false
    for i in ${IGNORE[@]}; do
        if [ $filename == $i ]; then
            ignores=true
        fi
    done
    if [ false == ${ignores} ]; then
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
    fi
done

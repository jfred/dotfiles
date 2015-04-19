#!/usr/bin/env bash
set -e

# save and change IFS 
OLDIFS=$IFS
IFS=$'\n'
 
# read all file name into an array
APPS=($(find /usr/local/Cellar/*/* -depth 1 -name '*.app'))
 
# restore it 
IFS=$OLDIFS

tLen=${#APPS[@]}
for (( i=0; i<tLen; i++ )); do
    f=${APPS[$i]}
   osascript -e "tell app \"Finder\" to make new alias file at POSIX file \"/Applications\" to POSIX file \"$f\""
done

#!/bin/sh
# from: http://superuser.com/a/413110/18228
dest="$1"
[ "x"${dest} != "x" ] || exit 1
tmux list-windows -F "#{window_index}" | grep "^${dest}$" 2>&1 > /dev/null
ret="$?"
if [ "x"${ret} = "x0" ] ; then
    tmux swap-window -t ":${dest}"
else
    tmux move-window -t ":${dest}"
fi

function node-docs {
    link=`echo $1 | sed "s/\./_/g;s/[()]//g"`
    open "http://nodejs.org/docs/$(node --version)/api/all.html#all_$link"
}

eval "$(npm completion 2>/dev/null)"

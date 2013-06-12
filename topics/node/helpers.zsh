function node-docs {
    link=`echo $1 | sed "s/\./_/g;s/[()]//g"`
    open "http://nodejs.org/docs/$(node --version)/api/all.html#all_$link"
}

function nodepath {
    export PATH="./node_modules/.bin:${PATH}"
}

eval "$(npm completion 2>/dev/null)"

#!/bin/bash

test_class="${1}"
phase="test"

# Project containing test
project=`find . -name ${test_class}.java | head -n 1 | sed -E 's#^\./##;s#/.*##'`

gradle_cmd="gradle -p ${project} -D${phase}.reportFormat=html,xml -D${phase}.single=${test_class} ${phase}"
if [ "${2}" == "debug" ]; then
    gradle="${gradle_cmd} -D${phase}.debug=true"
fi

echo ${gradle_cmd}
${gradle_cmd}

find ${project}/build -name "*${test_class}.xml"

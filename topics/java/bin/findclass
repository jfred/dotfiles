#!/bin/sh
find "$1" -name "*.jar" -exec sh -c 'jar -tf {}|grep -H --label {} '$2'' \;

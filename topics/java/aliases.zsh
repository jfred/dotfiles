# setup classpath from maven pom
alias mpath='export CLASSPATH="`pwd`/src/main:`pwd`/src/test:`mvn dependency:build-classpath | grep jar`"'

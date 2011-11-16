if [[ -d "${GWT_HOME}" ]]; then
	alias gwt='mvn com.totsp.gwt:maven-googlewebtoolkit2-plugin:gwt'
	alias gwttest='mvn com.totsp.gwt:maven-googlewebtoolkit2-plugin:gwt -Ptest'
	alias gwt-debug='mvn com.totsp.gwt:maven-googlewebtoolkit2-plugin:debug'
fi


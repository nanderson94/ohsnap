#!/bin/bash
export LD_LIBRARY_PATH=$(pwd):$LD_LIBRARY_PATH
if [ "$(uname)" == "Darwin" ]; then
	${BASH_SOURCE%/*}/node-webkit/osx-ia32/node-webkit.app/Contents/MacOS/node-webkit ${BASH_SOURCE%/*}/src/
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	if [ "$(uname -m)" == "x86_64" ]; then
		echo "Running linux-x64";
		${BASH_SOURCE%/*}/node-webkit/linux-x64/nw ${BASH_SOURCE%/*}/src/ "$@"
	else
		echo "Running linux-ia32";
		${BASH_SOURCE%/*}/node-webkit/linux-ia32/nw ${BASH_SOURCE%/*}/src/ "$@"
	fi
	echo -e "\n\nNOTICE: If you are getting a libudev error, check:";
	echo "https://github.com/rogerwang/node-webkit/wiki/The-solution-of-lacking-libudev.so.0";
fi

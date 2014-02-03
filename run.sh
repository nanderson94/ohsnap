#!/bin/bash
export LD_LIBRARY_PATH=$(pwd):$LD_LIBRARY_PATH
if [ "$(uname)" == "Darwin" ]; then
	./node-webkit/osx-ia32/node-webkit.app/Contents/MacOS/node-webkit src/
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	if [ "$(uname -m)" == "x86_64" ]; then
		echo "Running linux-x64";
		./node-webkit/linux-x64/nw src/
	else
		echo "Running linux-ia32";
		./node-webkit/linux-ia32/nw src/
	fi
	echo -e "\n\nNOTICE: If you are getting a libudev error, check:";
	echo "https://github.com/rogerwang/node-webkit/wiki/The-solution-of-lacking-libudev.so.0";
fi
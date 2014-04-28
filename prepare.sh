#1/bin/bash

# Repositories don't like it when we upload binaries,
# mainly because they're big

# This gets tricky because I need to modify the binaries...

# The "magic" command to fix libudev.so.0 > libudev.so.1
# sed -i 's/\x75\x64\x65\x76\x2E\x73\x6F\x2E\x30/\x75\x64\x65\x76\x2E\x73\x6F\x2E\x31/g' nw
# Thanks to https://github.com/rogerwang/node-webkit/issues/1703

if [ "x$1" = "x" ]; then
	echo -e "\e[0;37mWelcome to the \e[1;37mNode-Webkit\e[0;37m download wizard!\e[0m";
	echo -e "Please run this command in with one of the args below\n";
	echo -e "\tauto\t\tWhatever I'm using";
	echo -e "\tall\t\tAll (for building)";
	echo -e "\tlinux64\t\tLinux 64-bit";
	echo -e "\tlinux32\t\tLinux 32-bit";
	echo -e "\twin\t\tWindows 32/64-bit";
	echo -e "\tmac\t\tMac OSX";
else
	# Let's pull some scripts
	if [ "$1" = "all" ] || [ "$1" = "linux64" ]; then
		echo "Fetching files for Linux 64-bit...";
	  echo "Downloading binaries to: ${BASH_SOURCE%/*}/node-webkit/linux-x64";
		mkdir -p "${BASH_SOURCE%/*}/node-webkit/linux-x64"
		curl --silent http://dl.node-webkit.org/v0.9.2/node-webkit-v0.9.2-linux-x64.tar.gz | tar -xvzC "${BASH_SOURCE%/*}/node-webkit/linux-x64"
		mv "${BASH_SOURCE%/*}/node-webkit/linux-x64/node-webkit"*/* "${BASH_SOURCE%/*}/node-webkit/linux-x64" 
		rmdir "${BASH_SOURCE%/*}/node-webkit/linux-x64/node-webkit"*;
		echo "Patching node-webkit...";
		sed -i 's/\x75\x64\x65\x76\x2E\x73\x6F\x2E\x30/\x75\x64\x65\x76\x2E\x73\x6F\x2E\x31/g' "${BASH_SOURCE%/*}/node-webkit/linux-x64/nw";
	fi;
	if [ "$1" = "all" ] || [ "$1" = "linux32" ]; then
		echo "Fetching files for Linux 32-bit...";
	  echo "Downloading binaries to: ${BASH_SOURCE%/*}/node-webkit/linux-ia32";
		mkdir -p "${BASH_SOURCE%/*}/node-webkit/linux-ia32"
		curl --silent http://dl.node-webkit.org/v0.9.2/node-webkit-v0.9.2-linux-ia32.tar.gz | tar -xvzC "${BASH_SOURCE%/*}/node-webkit/linux-ia32"
		mv "${BASH_SOURCE%/*}/node-webkit/linux-ia32/node-webkit"*/* "${BASH_SOURCE%/*}/node-webkit/linux-ia32" 
		rmdir "${BASH_SOURCE%/*}/node-webkit/linux-ia32/node-webkit"*;
		echo "Patching node-webkit...";
		sed -i 's/\x75\x64\x65\x76\x2E\x73\x6F\x2E\x30/\x75\x64\x65\x76\x2E\x73\x6F\x2E\x31/g' "${BASH_SOURCE%/*}/node-webkit/linux-ia32/nw";
	fi;
	if [ "$1" = "all" ] || [ "$1" = "mac" ]; then
		echo "Fetching files for MacOS 32-bit...";
	  echo "Downloading binaries to: ${BASH_SOURCE%/*}/node-webkit/osx-ia32";
		mkdir -p "${BASH_SOURCE%/*}/node-webkit/osx-ia32"
		# Ugh, zip
		curl --silent "http://dl.node-webkit.org/v0.9.2/node-webkit-v0.9.2-osx-ia32.zip" -o "${BASH_SOURCE%/*}/node-webkit/osx-ia32/archive.zip"
		unzip "${BASH_SOURCE%/*}/node-webkit/osx-ia32/archive.zip" -d "${BASH_SOURCE%/*}/node-webkit/osx-ia32";
		rm "${BASH_SOURCE%/*}/node-webkit/osx-ia32/archive.zip";
		echo "Patching node-webkit...";
		sed -i 's/\x75\x64\x65\x76\x2E\x73\x6F\x2E\x30/\x75\x64\x65\x76\x2E\x73\x6F\x2E\x31/g' \
			"${BASH_SOURCE%/*}/node-webkit/osx-ia32/node-webkit.app/Contents/MacOS/node-webkit";
	fi;
	if [ "$1" = "all" ] || [ "$1" = "win" ]; then # How do I test for windows from bash? Namely cygwin
		echo "Fetching files for Windows 32-bit...";
	  echo "Downloading binaries to: ${BASH_SOURCE%/*}/node-webkit/win-ia32";
		mkdir -p "${BASH_SOURCE%/*}/node-webkit/win-ia32"
		# Ugh, zip
		curl --silent "http://dl.node-webkit.org/v0.9.2/node-webkit-v0.9.2-win-ia32.zip" -o "${BASH_SOURCE%/*}/node-webkit/win-ia32/archive.zip"
		unzip "${BASH_SOURCE%/*}/node-webkit/win-ia32/archive.zip" -d "${BASH_SOURCE%/*}/node-webkit/win-ia32";
		rm "${BASH_SOURCE%/*}/node-webkit/win-ia32/archive.zip";
		echo "Patching node-webkit...";
		sed -i 's/\x75\x64\x65\x76\x2E\x73\x6F\x2E\x30/\x75\x64\x65\x76\x2E\x73\x6F\x2E\x31/g' \
			"${BASH_SOURCE%/*}/node-webkit/win-ia32/nw.exe";
	fi; 
	if [ "$1" = "auto" ]; then
		if [ "$(uname)" == "Darwin" ]; then
			${BASH_SOURCE%/*}/$0 mac;
		elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
			if [ "$(uname -m)" == "x86_64" ]; then
				${BASH_SOURCE%/*}/$0 linux64;
			else
				${BASH_SOURCE%/*}/$0 linux32;
			fi
		else
			echo "Unable to detect your operating system, sorry! Please manually select one.";
		fi
	fi
fi

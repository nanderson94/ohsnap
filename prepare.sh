#1/bin/bash

# Repositories don't like it when we upload binaries,
# mainly because they're big

# This gets tricky because I need to modify the binaries...

# The "magic" command to fix libudev.so.0 > libudev.so.1
# sed -i 's/\x75\x64\x65\x76\x2E\x73\x6F\x2E\x30/\x75\x64\x65\x76\x2E\x73\x6F\x2E\x31/g' nw
# Thanks to https://github.com/rogerwang/node-webkit/issues/1703

if [ "x$1" = "x" ]; then
	echo -e "\e[0;37mWelcome to the \e[1;37mNode-Webkit\e[0;37m download wizard!\e[0m";
	echo -e "Please run this command with one of the args below\n";
	echo -e "\tauto\t\tWhatever I'm using";
	echo -e "\tall\t\tAll (for building)";
	echo -e "\tlinux64\t\tLinux 64-bit";
	echo -e "\tlinux32\t\tLinux 32-bit";
	echo -e "\twin\t\tWindows 32/64-bit";
	echo -e "\tmac\t\tMac OSX";
else
	# Let's pull some scripts
	if [ "$1" = "all" ] || [ "$1" = "linux64" ]; then
		echo "loonix64";
	fi;
	if [ "$1" = "all" ] || [ "$1" = "linux32" ]; then
		echo "loonix32";
	fi;
	if [ "$1" = "all" ] || [ "$1" = "mac" ]; then
		echo "mac";
	fi;
	if [ "$1" = "all" ] || [ "$1" = "win" ]; then # How do I test for windows from bash? Namely cygwin
		echo "win"
	fi; 
	if [ "$1" = "auto" ]; then
		if [ "$(uname)" == "Darwin" ]; then
			echo "Darwin"
		elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
			if [ "$(uname -m)" == "x86_64" ]; then
				echo "linux64";
			else
				echo "linux32";
			fi
		fi
	fi
fi

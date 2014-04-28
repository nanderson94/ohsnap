#!/bin/bash

SCRIPT=`realpath $0`;
SCRIPTPATH=`dirname $SCRIPT`;

# First we prune our output directory
rm -rf ${SCRIPTPATH}/packaged/

echo "Creating package..."
# Then we zip up the files
cd ${SCRIPTPATH}/src/
zip -rq app.nw *
cd ${SCRIPTPATH}
mv ${SCRIPTPATH}/src/app.nw ${SCRIPTPATH}/app.nw

if [ -d ${SCRIPTPATH}/node-webkit/linux-x64 ]; then
	echo "Building Linux64 version..."
	# Build the linux64 version
	mkdir -p ${SCRIPTPATH}/packaged/linux-x64/
	cat ${SCRIPTPATH}/node-webkit/linux-x64/nw ${SCRIPTPATH}/app.nw > ${SCRIPTPATH}/packaged/linux-x64/ohsnap_gui
	cp ${SCRIPTPATH}/node-webkit/linux-x64/nw.pak ${SCRIPTPATH}/packaged/linux-x64/nw.pak 2>/dev/null
	chmod +x ${SCRIPTPATH}/packaged/linux-x64/ohsnap_gui
fi
if [ -d ${SCRIPTPATH}/node-webkit/linux-ia32 ]; then
	echo "Building Linux32 version..."
	# Build the linux32 version
	mkdir -p ${SCRIPTPATH}/packaged/linux-ia32/
	cat ${SCRIPTPATH}/node-webkit/linux-ia32/nw ${SCRIPTPATH}/app.nw > ${SCRIPTPATH}/packaged/linux-ia32/ohsnap_gui
	cp ${SCRIPTPATH}/node-webkit/linux-ia32/nw.pak ${SCRIPTPATH}/packaged/linux-ia32/nw.pak 2>/dev/null
	chmod +x ${SCRIPTPATH}/packaged/linux-ia32/ohsnap_gui
fi
if [ -d $SCRIPTPATH/node-webkit/osx-ia32 ]; then
	echo "Building Mac32 version... Coming soon!"
fi
if [ -d ${SCRIPTPATH}/node-webkit/win-ia32 ]; then
	echo "Building Win32 version..."
	# Build the win32 version
	mkdir -p ${SCRIPTPATH}/packaged/win-ia32/
	cat ${SCRIPTPATH}/node-webkit/win-ia32/nw.exe ${SCRIPTPATH}/app.nw > ${SCRIPTPATH}/packaged/win-ia32/ohsnap_gui.exe
	cp -q ${SCRIPTPATH}/node-webkit/win-ia32/{nw.pak,icudt.dll,libEGL.dll,libGLESv2.dll,d3dx9_43.dll,D3DCompiler_43.dll} ${SCRIPTPATH}/packaged/win-ia32/ 2>/dev/null
fi
# Cleaning up
mv ${SCRIPTPATH}/app.nw ${SCRIPTPATH}/packaged/

# Success!
echo "Done!";


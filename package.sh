#!/bin/bash

SCRIPT=`realpath $0`;
SCRIPTPATH=`dirname $SCRIPT`;

# First we prune our output directory
rm -rf ${SCRIPTPATH}/packaged/
mkdir -p ${SCRIPTPATH}/packaged/linux64/
mkdir -p ${SCRIPTPATH}/packaged/win32/

echo "Creating package..."
# Then we zip up the files
cd ${SCRIPTPATH}/src/
zip -rq app.nw *
cd ${SCRIPTPATH}
mv ${SCRIPTPATH}/src/app.nw ${SCRIPTPATH}/app.nw

echo "Building Linux64 version..."
# Build the linux64 version
cat ${SCRIPTPATH}/node-webkit/linux-x64/nw ${SCRIPTPATH}/app.nw > ${SCRIPTPATH}/packaged/linux64/ohsnap_gui
cp ${SCRIPTPATH}/node-webkit/linux-x64/nw.pak ${SCRIPTPATH}/packaged/linux64/nw.pak 2>/dev/null
chmod +x ${SCRIPTPATH}/packaged/linux64/ohsnap_gui

echo "Building Win32 version..."
# Build the win32 version
cat ${SCRIPTPATH}/node-webkit/win32/nw.exe ${SCRIPTPATH}/app.nw > ${SCRIPTPATH}/packaged/win32/ohsnap_gui.exe
cp -q ${SCRIPTPATH}/node-webkit/win32/{nw.pak,icudt.dll,libEGL.dll,libGLESv2.dll,d3dx9_43.dll,D3DCompiler_43.dll} ${SCRIPTPATH}/packaged/win32/ 2>/dev/null

# Cleaning up
mv ${SCRIPTPATH}/app.nw ${SCRIPTPATH}/packaged/

# Success!
echo "Done!";


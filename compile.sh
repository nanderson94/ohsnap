#!/bin/bash

# Requires node-gyp
# sudo npm install -g nw-gyp

# Got directories with
# find src/ -name "*.gyp"
if [ -z $1 ]; then
	(cd src/node_modules/zombie/node_modules/jsdom/node_modules/contextify; nw-gyp rebuild --target=0.8.4 --python python2)
else
	(cd src/node_modules/zombie/node_modules/jsdom/node_modules/contextify; nw-gyp rebuild --target=$1 --python python2)
fi

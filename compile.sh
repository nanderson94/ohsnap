#!/bin/bash

# Requires node-gyp
# sudo npm install -g node-gyp

# Got directories with
# find src/ -name "*.gyp"
(cd src/node_modules/zombie/node_modules/jsdom/node_modules/contextify; nw-gyp rebuild --target=0.8.4 --python python2)
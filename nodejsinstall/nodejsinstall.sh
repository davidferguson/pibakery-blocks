#!/bin/bash
# this downloads and installs node.js
# 
version=v"$1"
device="$2"
#
# download the required nodejs version 
#
wget https://nodejs.org/dist/${version}/node-${version}-linux-${device}.tar.gz
#
# unpack and install nodejs
#
tar -xzf node-${version}-linux-${device}.tar.gz
node-${version}-linux-${device}/bin/node -v
cp -R node-${version}-linux-${device}/* /usr/local/
#
# cleanup temporary files and directories
#
rm node-${version}-linux-${device}.tar.gz
rm -rf node-${version}-linux-${device}

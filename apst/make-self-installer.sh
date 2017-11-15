#!/bin/bash
#
# Remake self-installer.sh after making any changes to etc/* or files/*
#
mkdir /tmp/se
cp -r etc /tmp/se/etc
cp files/installer /tmp/se
(cd /tmp/se; tar zcf /tmp/files.tar.gz .)
rm -rf /tmp/se
cat files/self-installer-header.sh /tmp/files.tar.gz > self-installer.sh
chmod +x self-installer.sh
rm -f /tmp/files.tar.gz


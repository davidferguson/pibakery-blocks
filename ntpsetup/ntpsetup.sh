#!/bin/bash
#
# this script will set an internal ntp server
# when internet ntp pool is not reachable
#
# $1: ip iddress of ntp server
#
config=ntp.conf
backup=`echo ${config} | sed 's/conf/bak/'`
mv ${config} ${backup}
cat ${backup} \
| sed 's/^server/#server/' \
| sed 's/ntp.your-provider.example/ntp.your-provider.example\nserver '$1'/' \
>${config}

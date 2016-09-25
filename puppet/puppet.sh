#!/bin/sh

# Created by Wesley Fisher. praetor@sdf.org @gwesfisher

apt-get update

apt-get install -y puppet libssl-dev

if [ -f /etc/puppet/puppet.conf ]; then
	echo "[agent]" >> /etc/puppet/puppet.conf
	echo "server=$1" >> /etc/puppet/puppet.conf
fi

puppet agent --enable

if [ $2 -eq "Yes"]; then
	puppet agent -t
fi

#!/bin/sh

file=/etc/bash_alias

if [ -e "$file" ]; then
	touch /etc/bash_alias
	echo "/etc/bash_alias" >> /etc/profile
	chmod 777 /etc/bash_alias
fi
echo "alias" $1"=\""$2"\""  >> /etc/bash_alias
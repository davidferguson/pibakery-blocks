#!/bin/bash
#
# add entry for static ip to /etc/dhcpcd.conf
#
# $1: the interface eth0, wlan0, or wlan1
# $2: the static ip address
# $3: the mask 255.x.x.0 with x = 255 or 0
# $4: the router address
# $5: the domain name server
#
ip_address="$2"
case "$3" in
    255.255.255.0)
        ip_address=${ip_address}"/24"
        ;;
    255.255.0.0)
        ip_address=${ip_address}"/16"
        ;;
    255.0.0.0)
        ip_address=${ip_address}"/8"
        ;;
esac
#
# copy existing dhcpcd.conf as dhcpcd.bak
#
file=/etc/dhcpcd.conf
cp ${file} `echo ${file} | sed 's/conf/bak/'`
#
# append static ip address information to dhcpcd.conf
#
echo "" >>${file}
echo "interface $1" >>${file}
echo "static ip_address=${ip_address}" >> ${file}
echo "static routers=$4" >>${file}
echo "static domain_name_servers=$5" >> ${file}

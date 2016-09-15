#!/usr/bin/env bash

function mask2cidr() {
    nbits=0
    IFS=.
    for dec in $1 ; do
        case $dec in
            255) let nbits+=8;;
            254) let nbits+=7;;
            252) let nbits+=6;;
            248) let nbits+=5;;
            240) let nbits+=4;;
            224) let nbits+=3;;
            192) let nbits+=2;;
            128) let nbits+=1;;
            0);;
            *) echo "Error: $dec is not recognised"; exit 1
        esac
    done
    echo "$nbits"
}

function getbroad() {
  local ip=$1
  local rawmask=$2
  IFS=. read -r io1 io2 io3 io4 <<< "$ip"
  IFS=. read -r mo1 mo2 mo3 mo4 <<< "$rawmask"
  mo1=$((255-mo1))
  mo2=$((255-mo2))
  mo3=$((255-mo3))
  mo4=$((255-mo4))
  broadcast="$((io1 | mo1)).$((io2 | mo2)).$((io3 | mo3)).$((io4 | mo4))"
  echo "$broadcast"
}

# Check for version of Debian as Jessie (8.0) prefers /etc/dhcpcd.conf over /etc/network/interfaces
if [ `cat /etc/debian_version | cut -d . -f 1` -ge 8 ]
then
  cidr=$(mask2cidr ${3})
  cp /etc/dhcpcd.conf /etc/dhcpcd.conf.original
  echo "" >> /etc/dhcpcd.conf
  echo "interface $1" >> /etc/dhcpcd.conf
  echo "static ip_address=$2/$cidr" >> /etc/dhcpcd.conf
  echo "static routers=$4" >> /etc/dhcpcd.conf
  echo "" >> /etc/dhcpcd.conf
else
  net=$
  broad=$(getbroad $2 $3)
  cp /etc/network/interfaces /etc/network/interfaces.original
  sed -i "/iface ${1} inet*/s/.*/iface ${1} inet static\\naddress $2\\ngateway$4\\nnetmask $3\\nbroadcast $broad/" /etc/network/interfaces
fi

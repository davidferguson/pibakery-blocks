#!/bin/bash

if [ "$1" == "Enable" ]
then
  TERM=linux /usr/bin/setterm -blank 0 > /dev/tty1
else
  TERM=linux /usr/bin/setterm -blank 600 > /dev/tty1
fi

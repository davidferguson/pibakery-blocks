#!/bin/bash

if [ "$1" == "Enable" ]
then
  touch /boot/ssh
else
  rm /boot/ssh
fi
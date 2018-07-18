#!/bin/bash

if [ "$1" == "Enable" ]
then
  systemctl enable ssh.service
  systemctl start ssh.service
else
  systemctl disable ssh.service
  systemctl stop ssh.service
fi

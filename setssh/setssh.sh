#!/bin/bash

if [ "$1" == "Enable" ]
then
  raspi-config nonint do_ssh 0
else
  raspi-config nonint do_ssh 1
fi

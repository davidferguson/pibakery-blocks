#!/bin/bash

if [ "$1" == "Enable" ]
then
  raspi-config nonint do_camera 0
else
  raspi-config nonint do_camera 1
fi

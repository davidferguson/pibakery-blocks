#!/bin/bash

if [ "$1" == "Enable" ]
then
  raspi-config nonint do_expand_rootfs
fi
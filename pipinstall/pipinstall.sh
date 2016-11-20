#!/bin/bash

apt-get update

if [ "$2" == "pip" ]; then
  DEBIAN_FRONTEND=noninteractive apt-get install -y python-pip
  pip install "$1"
else
  DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip
  pip3 install "$1"
fi

#!/bin/bash

if [ "$2" == "pip" ]; then
  hash pip list &> /dev/null
  if ! [ $? -eq 0 ]; then
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y python-pip
  fi
  
  pip install "$1"

else
  hash pip3 list &> /dev/null
  if ! [ $? -eq 0 ]; then
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip
  fi

  pip3 install "$1"
fi

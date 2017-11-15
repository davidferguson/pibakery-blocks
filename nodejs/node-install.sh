#!/bin/bash

version="$1"

curl -sL https://deb.nodesource.com/setup_$version | sudo bash -
apt-get install nodejs -y


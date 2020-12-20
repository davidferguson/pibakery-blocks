#!/bin/bash
sudo sh -c "echo $1 > /etc/timezone"
sudo cp /usr/share/zoneinfo/$1 /etc/localtime
#!/bin/bash

# First try to install rpi-update, as it doesn't exist on raspbian lite
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y install rpi-update

SKIP_WARNING=1 rpi-update

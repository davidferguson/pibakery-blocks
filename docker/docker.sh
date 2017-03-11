#!/bin/bash

# This script is intended to be run as root or using sudo
# Compatible with Docker Community Edition (since the instructions don't work for Raspbian on the official website)
# Requires an internet connection

export DEBIAN_FRONTEND=noninteractive

# Install pre-requisites
apt-get install -y -q --no-install-recommends \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common

# Grab apt-key
apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# Split up pre-reqs to be more similar to the official install script (note linux-image-extras and linux-image-virtual
# are not available on Raspbian at this time)
apt-get install -y -q --no-install-recommends \
     apparmor \
     dirmngr

# Create sources.list.d directory
mkdir -p /etc/apt/sources.list.d

# Add apt repository manually (cannot be added using add-apt-repository!)
echo "deb [arch=armhf] https://apt.dockerproject.org/repo raspbian-jessie main" > /etc/apt/sources.list.d/docker.list

# Check if old docker is installed, if it is, remove it
if [ $(dpkg-query -W -f='${Status}' docker 2>/dev/null | grep -c "ok installed") -eq 1 ];
then
	apt-get remove -y -q --purge docker;
fi

# Check if Docker is installed, if not install it
if [ $(dpkg-query -W -f='${Status}' docker-engine 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
	apt-get update && apt-get -y -q install docker-engine;
else
	# Docker is installed-so we'll remove it and re-install to ensure we have the latest version
	apt-get remove -y -q --purge docker-engine;
	apt-get update && apt-get -y -q install docker-engine;
fi

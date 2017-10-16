#!/bin/bash
echo 'deb http://www.ubnt.com/downloads/unifi/debian $1 ubiquiti' | sudo tee -a /etc/apt/sources.list.d/ubnt.list > /dev/null
apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50
apt-get update
apt-get install unifi oracle-java8-jdk mongodb -y
echo 'ENABLE_MONGODB=no' | sudo tee -a /etc/mongodb.conf > /dev/null
cp /lib/systemd/system/unifi.service /etc/systemd/system/
sed -i '/^\[Service\]$/a Environment=JAVA_HOME=/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt' /etc/systemd/system/unifi.service
#apt-get update && sudo apt-get upgrade -y
#apt-get install rpi-update && echo Y | sudo rpi-update

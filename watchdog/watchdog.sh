#!/bin/bash
# this installs and starts the watchdog service
#
if [ "$1" == "Install and enable" ]
then
#
# install the watchdog
#
    apt-get -y install watchdog
    sudo modprobe bcm2835_wdt
    echo "bcm2835_wdt" | sudo tee -a /etc/modules
#
# add "WantedBy=multi-user.target" to the watchdog.service
#
    echo WantedBy=multi-user.target >>/lib/systemd/system/watchdog.service
#
# modify the watchdog.conf
#   enable max-load-1
#   insert watchdog-timeout = 10
#   enable watchdog-device
#
    mv /etc/watchdog.conf /etc/watchdog.bak
    cat /etc/watchdog.bak | sed 's/#max-load-1/max-load-1/' | sed 's/#watchdog-device/watchdog-timeout = 10\nwatchdog-device/' >/etc/watchdog.conf

#
# enable and start the watchdog
#
    systemctl enable watchdog.service
    systemctl start watchdog.service
else
#
# stop and disable the watchdog
#
    systemctl stop watchdog.service
    systemctl disable watchdog.service
fi
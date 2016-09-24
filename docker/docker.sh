#!/bin/bash
curl -sSL https://downloads.hypriot.com/docker-hypriot_1.10.3-1_armhf.deb >/tmp/docker-hypriot_1.10.3-1_armhf.deb
dpkg -i /tmp/docker-hypriot_1.10.3-1_armhf.deb
rm -f /tmp/docker-hypriot_1.10.3-1_armhf.deb
usermod -aG docker pi
systemctl enable docker.service

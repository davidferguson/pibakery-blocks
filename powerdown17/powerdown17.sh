#!/bin/bash
mkdir /home/pi/powerdown
cp /boot/PiBakery/blocks/powerdown17/powerdown.py /home/pi/powerdown/powerdown.py
su - root -c cp /boot/PiBakery/blocks/powerdown17/powerdown.service /etc/systemd/system/powerdown.service
su - root -c chmod +x /home/pi/powerdown/powerdown.py
su - root -c systemctl enable powerdown.service
su - root -c systemctl start  powerdown.service

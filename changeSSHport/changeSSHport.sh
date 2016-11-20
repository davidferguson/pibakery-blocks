#!/bin/bash

sudo sed -i 's/Port 22/Port '"$1"'/' /etc/ssh/sshd_config

/etc/init.d/ssh restart

sleep 2

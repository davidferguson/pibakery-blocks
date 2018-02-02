#!/bin/bash
sudo ifconfig "$2" down
sudo iwconfig "$2" mode "$1"
sudo ifconfig "$2" up
#!/bin/bash
apt-get update
cd /boot/PiBakery/blocks
git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
cd /boot/PiBakery/blocks/RetroPie-Setup
./retropie_setup.sh

#!/bin/bash
sudo apt-get install -y git
raspi-config nonint do_hostname "$4"
git clone https://github.com/eddwatts/raspadmin.git
sed -i 's/=XX/='$1'/' /home/pi/raspadmin/installernq
sed -i 's/=YY/='$2'/' /home/pi/raspadmin/installernq
sed -i 's/=ZZ/='$3'/' /home/pi/raspadmin/installernq
sed -i 's/=VV/='$4'/' /home/pi/raspadmin/installernq
cd raspadmin
sudo ./installernq
cd modules
./installer
sudo service raspadmin enable
sudo service raspadmin start
exit 0

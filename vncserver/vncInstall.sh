apt-get update
#DEBIAN_FRONTEND=noninteractive apt-get -y install tightvncserver
dpkg -i xfonts-base_1.0.3_all.deb tightvncserver_1.3.9-6.5_armhf.deb

chmod +x /boot/PiBakery/blocks/vncserver/vncSetup.sh
su - pi -c "/boot/PiBakery/blocks/vncserver/vncSetup.sh $@"

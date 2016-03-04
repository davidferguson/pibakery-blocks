apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y install tightvncserver

chmod +x /boot/PiBakery/blocks/vncserver/vncSetup.sh
su - pi -c "/boot/PiBakery/blocks/vncserver/vncSetup.sh $@"

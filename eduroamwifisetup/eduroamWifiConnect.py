#!/usr/bin/python
import sys, os, time

networkText = """

network={
          ssid="eduroam"
          scan_ssid=1
          key_mgmt=WPA-EAP
          eap=PEAP
          identity="username"
          password="userpassword"
          phase1="peaplabel=0"
          phase2="auth=MSCHAPV2"
          priority=1
}
"""

userName = sys.argv[1]
userPassword = sys.argv[2]
countryCode = sys.argv[3]

if userName != "" and userPassword != "":
    networkText = networkText.replace("username", userName)
    networkText = networkText.replace("userpassword", userPassword)

# raspbian 2018-03-14 now requires us to have the country= line.
os.system('raspi-config nonint do_wifi_country "' + countryCode + '"')

with open("/etc/wpa_supplicant/wpa_supplicant.conf", "a") as wifiFile:
	wifiFile.write(networkText)

os.system("wpa_cli reconfigure")
time.sleep(5)
os.system("systemctl daemon-reload")
time.sleep(5)
os.system("systemctl restart dhcpcd")
time.sleep(5)

if sys.argv[4] == "Yes":
    # It's likely that the block following this one will be one that uses the
    # internet - such as a download file or apt-get block. It takes a few seconds
    # for the WiFi to connect and obtain an IP address, run the waitForNetwork shell
    # script, which will loop waiting for a network connection (timeout 150 seconds)
    # and continue once there is one
    os.system("chmod +x /boot/PiBakery/blocks/eduroamwifisetup/waitForNetwork.sh")
    os.system("/boot/PiBakery/blocks/eduroamwifisetup/waitForNetwork.sh")

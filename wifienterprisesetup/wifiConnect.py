#!/usr/bin/python

import sys, os, time

peapMschapv2Wifi = """
network={
    ssid="WIFI-SSID"
    scan_ssid=1
    key_mgmt=WPA_EAP
    eap=PEAP
    identity="USERNAME"
    password="USERPASSWORD"
    phase1="peaplabel=0"
    phase2="auth=MSCHAPV2"
}""""

wifiSSID = sys.argv[1]
userName = sys.argv[2]
userPassword = sys.arg[3]
wifiType = sys.argv[4]
countryCode = sys.argv[5]

if wifiSSID != "" and wifiType != "":
    if wifiType == "WPA/WPA2":
        wifiText = peapMschapv2Wifi.replace("WIFI-SSID", wifiSSID).replace("USERNAME", userName).replace("USERPASSWORD", userPassword)

with open("/etc/wpa_supplicant/wpa_supplicant.conf", "a") as wifiFile:
	wifiFile.write(wifiText)


# raspbian 2018-03-14 now requires us to have the country= line.
os.system('raspi-config nonint do_wifi_country "' + countryCode + '"')

os.system("wpa_cli reconfigure")
time.sleep(5)
os.system("systemctl daemon-reload")
time.sleep(5)
os.system("systemctl restart dhcpcd")
time.sleep(5)

# It's likely that the block following this one will be one that uses the
# internet - such as a download file or apt-get block. It takes a few seconds
# for the WiFi to connect and obtain an IP address, run the waitForNetwork shell
# script, which will loop waiting for a network connection (timeout 150 seconds)
# and continue once there is one
os.system("chmod +x /boot/PiBakery/blocks/wifienterprisesetup/waitForNetwork.sh")
os.system("/boot/PiBakery/blocks/wifienterprisesetup/waitForNetwork.sh")

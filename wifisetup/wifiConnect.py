#!/usr/bin/env python

import sys, os

wpaWifi = """

network={
    ssid="WIFI-SSID"
    psk="WIFI-PSK"
}"""

openWifi = """

network={
    ssid="WIFI-SSID"
    key_mgmt=NONE
}"""

wifiSSID = sys.argv[1]
wifiPSK = sys.argv[2]

if wifiSSID != "":
	if wifiPSK != "":
		wifiText = wpaWifi.replace("WIFI-SSID", wifiSSID).replace("WIFI-PSK", wifiPSK)
	else:
		wifiText = openWifi.replace("WIFI-SSID", wifiSSID)

os.system("killall wpa_supplicant")
with open("/etc/wpa_supplicant/wpa_supplicant.conf", "a") as wifiFile:
	wifiFile.write(wifiText)

os.system("/sbin/wpa_supplicant -s -B -P /run/wpa_supplicant.wlan0.pid -i wlan0 -D nl80211,wext -c /etc/wpa_supplicant/wpa_supplicant.conf")
os.system("dhclient wlan0")

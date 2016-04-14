#!/usr/bin/env python

import sys, os

wifiText = """

network={
    ssid="WIFI-SSID"
    psk="WIFI-PSK"
}"""

wifiSSID = sys.argv[1]
wifiPSK = sys.argv[2]

wifiText = wifiText.replace("WIFI-SSID", wifiSSID).replace("WIFI-PSK", wifiPSK)

os.system("killall wpa_supplicant")
with open("/etc/wpa_supplicant/wpa_supplicant.conf", "a") as wifiFile:
	wifiFile.write(wifiText)

os.system("/sbin/wpa_supplicant -s -B -P /run/wpa_supplicant.wlan0.pid -i wlan0 -D nl80211,wext -c /etc/wpa_supplicant/wpa_supplicant.conf")
os.system("dhclient wlan0")

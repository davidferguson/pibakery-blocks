#!/usr/bin/env python

import sys, os, time

openWifi = """

network={
    ssid="WIFI-SSID"
    scan_ssid=1
    key_mgmt=NONE
}"""

wepWifi = """

network={
    ssid="WIFI-SSID"
    scan_ssid=1
    key_mgmt=NONE
    wep_key0="WIFI-PSK"
}"""

wpaWifi = """

network={
    ssid="WIFI-SSID"
    scan_ssid=1
    key_mgmt=WPA-PSK
    psk="WIFI-PSK"
}"""

wifiSSID = sys.argv[1]
wifiPSK = sys.argv[2]
wifiType = sys.argv[3]

if wifiSSID != "" and wifiType != "":
	if wifiPSK == "" or wifiType == "Open (no password)":
		wifiText = openWifi.replace("WIFI-SSID", wifiSSID)
	elif wifiType == "WEP":
		wifiText = wepWifi.replace("WIFI-SSID", wifiSSID).replace("WIFI-PSK", wifiPSK)
	elif wifiType == "WPA/WPA2":
		wifiText = wpaWifi.replace("WIFI-SSID", wifiSSID).replace("WIFI-PSK", wifiPSK)

with open("/etc/wpa_supplicant/wpa_supplicant.conf", "a") as wifiFile:
	wifiFile.write(wifiText)

os.system("wpa_cli reconfigure")

#It's likely that the block following this one will be one that uses the internet - such
#as a download file or apt-get block. It takes a few seconds for the WiFi to connect and
#obtain an IP address, so wat 30 seconds to make sure that if we can connect, we will
#have
time.sleep(30)

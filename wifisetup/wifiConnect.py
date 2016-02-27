import sys, os

wifiText = """

network={
    ssid="WIFI-SSID"
    psk="WIFI-PSK"
}"""

wifiSSID = sys.argv[1]
wifiPSK = sys.argv[2]

wifiText.replace("WIFI-SSID", wifiSSID).replace("WIFI-PSK", wifiPSK)

with open("/etc/wpa_supplicant/wpa_supplicant.conf", "a") as wifiFile:
	wifiFile.write(wifiText)

os.system("ifdown wlan0")
os.system("ifup wlan0")

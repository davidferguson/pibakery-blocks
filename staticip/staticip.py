#!/usr/bin/python

import sys, os, time

setWiFi = """

interface wlan0

static ip_address=STATIC-IP
static routers=ROUTER-IP
static domain_name_servers=DNS-IP

}"""

setEth = """

interface eth0

static ip_address=STATIC-IP
static routers=ROUTER-IP
static domain_name_servers=DNS-IP

}"""

setBoth = """

interface eth0

static ip_address=STATIC-IP
static routers=ROUTER-IP
static domain_name_servers=DNS-IP

interface wlan0

static ip_address=STATIC-IP
static routers=ROUTER-IP
static domain_name_servers=DNS-IP

}"""

staticIP = sys.argv[1]
routerIP = sys.argv[2]
dnsIP = sys.argv[3]
type = sys.argv[4]

if type == "WiFi":
	ipText = setWiFi.replace("STATIC-IP", staticIP).replace("ROUTER-IP", routerIP).replace("DNS-IP", dnsIP)
elif type == "Ethernet":
	ipText = setEth.replace("STATIC-IP", staticIP).replace("ROUTER-IP", routerIP).replace("DNS-IP", dnsIP)
else:
	ipText = setBoth.replace("STATIC-IP", staticIP).replace("ROUTER-IP", routerIP).replace("DNS-IP", dnsIP)

with open("/etc/dhcpcd.conf", "a") as ipFile:
	ipFile.write(ipText)

os.system("/etc/init.d/networking restart")
time.sleep(5)



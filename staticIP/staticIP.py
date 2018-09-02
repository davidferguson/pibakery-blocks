#!/usr/bin/python

import sys, os, time

# Read the config file
with open("/etc/network/interfaces", "r") as f:
    configFile = f.readlines()

interface = sys.argv[1]
IP = sys.argv[2]
netmask = sys.argv[3]
gateway = sys.argv[4]

for line in configFile:
    if not line.startswith("#"): # ignore comments

        # Find interface configuration line
        if line.startswith("iface " + interface + " inet"):
            index = configFile.index(line)
            configFile.pop(index)
            configFile.insert(index, "iface " + interface + " inet static\n")

            configFile.insert(index+1, "    address " + IP + "\n")
            configFile.insert(index+2, "    netmask " + netmask + "\n")
            configFile.insert(index+3, "    gateway " + gateway + "\n")

            break

# Write the config file with the changes
with open("/etc/network/interfaces", "w") as f:
    for line in configFile:
        f.write(line)

os.system("/etc/init.d/networking restart")
time.sleep(5)

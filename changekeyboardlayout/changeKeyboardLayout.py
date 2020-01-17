#!/usr/bin/python
import sys

filename = "/etc/default/keyboard"

model = sys.argv[1]
layout = sys.argv[2]
variant = sys.argv[3]
options = sys.argv[4]

text = ""

# read the text in the file
with open(filename) as f:
    line = f.readline()

# replace the lines in the file with the desired settings
    while line:
       print line.strip()
       if line.find('XKBMODEL') > -1:
         line = "XKBMODEL=\""+model+"\"\n"
       elif line.find('XKBLAYOUT') > -1:
         line = "XKBLAYOUT=\""+layout+"\"\n"
       elif line.find('XKBVARIANT') > -1:
         line = "XKBVARIANT=\""+variant+"\"\n"
       elif line.find('XKBOPTIONS') > -1:
         line = "XKBOPTIONS=\""+options+"\"\n"

       text = text + line
       line = f.readline()

# write the changed text back to the file
with open(filename, "w") as f:
    f.write(text)

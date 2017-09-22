#!/usr/bin/python

import shutil
import sys

source = sys.argv[1]
dest = sys.argv[2]
optype = sys.argv[3]

if optype == "Copy":
    shutil.copy2(source, dest)
elif optype == "Move":
    shutil.move(source, dest)

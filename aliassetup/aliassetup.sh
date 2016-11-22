#!/bin/sh

echo ""  >> /etc/bash_alias
chmod x /etc/bash_alias
echo "/etc/bash_alias" >> /etc/profile
echo "Global alias /etc/bash_alias activated"
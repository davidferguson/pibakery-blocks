#!/bin/bash

text="@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
@xset s off
@xset -dpms
@xset s noblank
@chromium-browser --noerrdialogs --kiosk --disable-session-crashed-bubble --disable-infobars -no-first-run "$1"
@unclutter -idle 0.1 -root"

echo "$text" > /home/pi/.config/lxsession/LXDE-pi/autostart
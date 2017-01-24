#!/bin/bash

text="@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
@xset s off
@xset -dpms
@xset s noblank
@sed -i 's/\"exited_cleanly\": false/\"exited_cleanly\": true/' ~/.config/chromium/Default/Preferences
@chromium-browser --noerrdialogs --kiosk --disable-session-crashed-bubble -no-first-run "$1"
@unclutter -idle 0.1 -root"

echo "$text" > /home/pi/.config/lxsession/LXDE-pi/autostart
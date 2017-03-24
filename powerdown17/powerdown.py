#!/usr/bin/env python

# based on Daniel Bull's LiPoPi project - https://github.com/NeonHorizon/lipopi

import os
import RPi.GPIO as GPIO
import time

# Configure the GPIO pins

def lipopi_setup():
    global lipopi

    GPIO.setwarnings(False)
    GPIO.setmode(GPIO.BCM)

    GPIO.setup(lipopi['shutdown_pin'], GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(lipopi['reboot_pin'], GPIO.IN, pull_up_down=GPIO.PUD_UP)

    GPIO.add_event_detect(lipopi['shutdown_pin'], GPIO.FALLING, callback=lipopi_user_shutdown, bouncetime=300)
    GPIO.add_event_detect(lipopi['reboot_pin'], GPIO.FALLING, callback=lipopi_user_reboot, bouncetime=300)

def lipopi_user_reboot(channel):
    global lipopi

    cmd = "sudo wall 'System shutting down in %d seconds'" % lipopi['shutdown_wait']
    os.system(cmd)

    time.sleep(lipopi['shutdown_wait'])

    GPIO.cleanup()
    os.system("sudo reboot")


# Detect when the switch is pressed - wait shutdown_wait seconds - then shutdown

def lipopi_user_shutdown(channel):
    global lipopi

    cmd = "sudo wall 'System shutting down in %d seconds'" % lipopi['shutdown_wait']
    os.system(cmd)

    time.sleep(lipopi['shutdown_wait'])

    GPIO.cleanup()
    os.system("sudo shutdown now -h")

# Close the log file, reset the GPIO pins
def lipopi_cleanup():
    global lipopi
#    lipopi['logfile_pointer'].close()
    GPIO.cleanup()

# Main --------------------------------------------
# Setup LiPoPi global variable array

lipopi = {}

lipopi['shutdown_pin']    =17
lipopi['reboot_pin']    =18

lipopi['shutdown_wait'] = 2  # seconds - how long to wait before actual shutdown - can be 0 if you want

# setup the GPIO pins and event triggers

lipopi_setup()

# Although the shutdown is triggered by an interrupt, we still need a loop
# to keep the script from exiting - just do a very long sleep

while True:
    time.sleep(6000)

# clean up if the script exits without machine shutdown

lipopi_cleanup()

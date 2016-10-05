#!/bin/bash
if sudo grep "#framebuffer_width=1280" /boot/config.txt
then
        sudo sed -i "s/#framebuffer_width=1280/framebuffer_width=1280/g" /boot/config.txt
fi
if sudo grep "#framebuffer_height=720" /boot/config.txt
then
        sudo sed -i "s/#framebuffer_height=720/framebuffer_height=720/g" /boot/config.txt
fi

exit

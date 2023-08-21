#!/bin/bash

DEVICE_A="alsa_output.pci-0000_2d_00.1.hdmi-stereo"
DEVICE_B="alsa_output.usb-HP__Inc_HyperX_Cloud_Alpha_Wireless_00000001-00.analog-stereo"

CURRENT_SINK=$(pacmd list-sinks | grep '* index:' -A 1 | grep 'name:' | cut -d'<' -f2 | cut -d'>' -f1)

if [ "$CURRENT_SINK" == "$DEVICE_A" ]; then
    pacmd set-default-sink $DEVICE_B
    echo 2
else
    pacmd set-default-sink $DEVICE_A
    echo 1
fi


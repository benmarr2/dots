#!/bin/bash
DEVICE_A="alsa_output.pci-0000_2d_00.1.hdmi-stereo"  
DEVICE_B="alsa_output.usb-HP__Inc_HyperX_Cloud_Alpha_Wireless_00000001-00.analog-stereo"

ICON_A="󱥯" 
ICON_B="󰋋"  

CURRENT_SINK=$(pacmd list-sinks | grep '* index:' -A 1 | grep 'name:' | cut -d'<' -f2 | cut -d'>' -f1)

if [ "$CURRENT_SINK" == "$DEVICE_A" ]; then
    echo "$ICON_A"
elif [ "$CURRENT_SINK" == "$DEVICE_B" ]; then
    echo "$ICON_B"
else
    echo ""  
fi


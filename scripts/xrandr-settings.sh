#!/bin/bash

# Set DP-4 to primary, resolution 3440x1440 and refresh rate 165Hz
xrandr --output DP-4 --mode 3440x1440 --rate 165 --primary

# Set HDMI-1 to the left of DP-4, resolution 1920x1080 and refresh rate 60Hz
xrandr --output HDMI-1 --rate 60 --left-of DP-4

# Set DP-2 to the right of DP-4, resolution 1920x1080 and refresh rate 75Hz
xrandr --output DP-2 --mode 1920x1080 --rate 75 --right-of DP-4

#!/usr/bin/env bash
pkill waybar
rofi -show drun -theme ~/.config/rofi/rofidmenu.rasi
waybar &

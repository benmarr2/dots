#!/usr/bin/env bash

options="󰒲  Suspend\n󰤄  Shutdown\n󰜉  Reboot\n󰍃  Logout"

chosen="$(echo -e "$options" | rofi -dmenu -i -p "Power" \
  -theme ~/.config/rofi/rofipowermenu.rasi)"

case "$chosen" in
  *Suspend*) systemctl suspend ;;
  *Shutdown*) systemctl poweroff ;;
  *Reboot*) systemctl reboot ;;
  *Logout*) hyprctl dispatch exit ;;
  *) exit 0 ;;
esac

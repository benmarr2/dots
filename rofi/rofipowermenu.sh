#!/usr/bin/env bash

# Kill existing Waybar
pkill waybar

options="󰒲  Suspend\n󰤄  Shutdown\n󰜉  Reboot\n󰍃  Logout"

chosen="$(echo -e "$options" | rofi -dmenu -i -p "Power" \
  -theme ~/.config/rofi/rofipowermenu.rasi)"

# If user hit Escape or closed Rofi, $chosen will be empty
if [ -z "$chosen" ]; then
  waybar &
  exit 0
fi

case "$chosen" in
  *Suspend*) systemctl suspend ;;
  *Shutdown*) systemctl poweroff ;;
  *Reboot*) systemctl reboot ;;
  *Logout*) hyprctl dispatch exit ;;
  *) ;;  # just in case, but normally won't hit this now
esac

# For actions like suspend, after resume this will run.
# For shutdown/logout, the system/session will be gone anyway.
waybar &

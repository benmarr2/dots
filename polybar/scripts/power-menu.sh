
#!/bin/sh

chosen=$(printf " Lock\n Suspend\n Reboot\n⏻ Shutdown\n Logout" | rofi -dmenu -i -p "Power")

case "$chosen" in
    " Lock") i3lock ;;
    " Suspend") systemctl suspend ;;
    " Reboot") systemctl reboot ;;
    "⏻ Shutdown") systemctl poweroff ;;
    " Logout") i3-msg exit ;;
esac

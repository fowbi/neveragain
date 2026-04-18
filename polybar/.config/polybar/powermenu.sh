#!/usr/bin/env bash

chosen=$(printf "Logout\nSleep\nReboot\nShutdown" | rofi -dmenu -p "Power" -i)

case "$chosen" in
  Logout)   i3-msg exit ;;
  Sleep)    systemctl suspend ;;
  Reboot)   systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac

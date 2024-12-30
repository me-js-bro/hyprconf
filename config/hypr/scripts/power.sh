#!/bin/bash

case $1 in
    --poweroff)
        systemctl poweroff --now
        ;;
    --reboot)
        systemctl reboot --now
        ;;
    --logout)
        hyprctl dispatch exit 0
        ;;
    --lock)
        hyprlock
        ;;
esac

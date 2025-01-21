#!/bin/bash


case "$1" in
    --reload)
        killall waybar
        waybar &
        sleep 0.3
        hyprctl reload
        ;;
    --toggle)
        killall waybar || waybar &
        sleep 0.5
        hyprctl reload
        ;;
esac


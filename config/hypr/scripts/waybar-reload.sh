#!/bin/bash


case "$1" in
    --reload)
        killall waybar
        waybar &
        sleep 0.2
        hyprctl reload
        ;;
    --toggle)
        killall waybar || waybar &
        sleep 0.2
        hyprctl reload
        ;;
esac


#!/bin/bash

case "$1" in
    up)
        brightnessctl set +10%
        ;;
    down)
        brightnessctl set 10%-
        ;;
esac

# Optional: Notify the user about the current brightness level
current_brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
percentage=$(( current_brightness * 100 / max_brightness ))
notify-send "Brightness: $percentage%"

#!/bin/bash

mode_file="$HOME/.mode"
scripts_dir="$HOME/.config/hypr/scripts"
cache_dir="$HOME/.config/hypr/.cache"

if [ ! -f "$mode_file" ]; then
    "$scripts_dir"/toggle_dark_light.sh
else
    current_mode=$(cat "$mode_file")
    if [ "$current_mode" = "light" ]; then
        wallDIR="$HOME/.config/hypr/Dynamic-Wallpapers/light"
    elif [ "$current_mode" = "dark" ]; then
        wallDIR="$HOME/.config/hypr/Dynamic-Wallpapers/dark"
    fi

    PICS=($(find ${wallDIR} -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))
    RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}


    # Transition config
    FPS=60
    TYPE="any"
    DURATION=2
    BEZIER=".43,1.19,1,.4"
    SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

    notify-send -i "${RANDOMPICS}" "Changing wallpaper ${RANDOMPICS}"
    swww query || swww init && swww img ${RANDOMPICS} $SWWW_PARAMS
fi


sleep 0.5
${scripts_dir}/pywal.sh
sleep 0.2
${scripts_dir}/Refresh.sh

sleep 0.2
# creating a blur image for hyprlock
mkdir -p "$cache_dir"
if [ -d "$cache_dir" ]; then
    convert "$cache_dir/current_wallpaper.png" -blur 0x20 -resize 100% "$cache_dir/blurred.png"
    notify-send -e "Blurred.png" "Created a blurred version of your Wallpaper"
fi

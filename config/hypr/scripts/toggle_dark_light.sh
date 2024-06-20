#!/bin/bash

mode_file="$HOME/.mode"
wallpaper_dir_dark="$HOME/.config/hypr/Dynamic-Wallpapers/dark"
wallpaper_dir_light="$HOME/.config/hypr/Dynamic-Wallpapers/light"
scriptsDir="$HOME/.config/hypr/scripts"
cache_dir="$HOME/.config/hypr/.cache"

# Create the mode file if it doesn't exist
touch "$mode_file"

# Transition config
FPS=60
TYPE="any"
DURATION=2
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

# Read the current mode
current_mode=$(cat "$mode_file")

set_random_wallpaper_swww() {
    wallpaper_files=("$1"/*)
    random_wallpaper="${wallpaper_files[RANDOM % ${#wallpaper_files[@]}]}"
    swww query || swww init && swww img ${random_wallpaper} $SWWW_PARAMS
}

if [ "$current_mode" == "dark" ]; then
    # Switch to light mode

    # gtk theme
    gsettings set org.gnome.desktop.interface gtk-theme "theme-light"

    # switch wallpaper
    set_random_wallpaper_swww "$wallpaper_dir_light"
    echo "light" > "$mode_file"
else
    # Switch to dark mode

    # gtk theme
    gsettings set org.gnome.desktop.interface gtk-theme "theme"

    # set wallpaper
    set_random_wallpaper_swww "$wallpaper_dir_dark"
    echo "dark" > "$mode_file"
fi

sleep 0.5
${scriptsDir}/pywal.sh
sleep 0.2
${scriptsDir}/Refresh.sh

mkdir -p "$cache_dir"
if [ -d "$cache_dir" ]; then
    convert "$cache_dir/current_wallpaper.png" -blur 0x20 -resize 100% "$cache_dir/blurred.png"
    notify-send -e " " "Created a blurred version of your Wallpaper"
fi


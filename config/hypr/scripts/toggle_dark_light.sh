#!/bin/bash

mode_file="$HOME/.mode"
wallpaper_dir_dark="$HOME/.config/hypr/Dynamic-Wallpapers/dark"
wallpaper_dir_light="$HOME/.config/hypr/Dynamic-Wallpapers/light"
scripts_dir="$HOME/.config/hypr/scripts"
cache_dir="$HOME/.config/hypr/.cache"
engine_file="$cache_dir/.engine"

# Create the mode file if it doesn't exist
touch "$mode_file"

# Transition config
FPS=60
TYPE="any"
DURATION=2
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

# Read the current mode and wallpaper engine
current_mode=$(cat "$mode_file")
engine=$(cat "$engine_file")

set_random_wallpaper_swww() {
    wallpaper_files=("$1"/*)
    random_wallpaper="${wallpaper_files[RANDOM % ${#wallpaper_files[@]}]}"
    swww query || swww init && swww img ${random_wallpaper} $SWWW_PARAMS
}

set_random_wallpaper_hyprpaper() {
    wallpaper_files=("$1"/*)
    random_wallpaper="${wallpaper_files[RANDOM % ${#wallpaper_files[@]}]}"

    # Ensure hyprpaper is running
        if ! pgrep -x hyprpaper > /dev/null; then
        hyprpaper -c ~/.config/hypr/hyprpaper.conf &
        sleep 2  # give hyprpaper some time to start
        fi

        # Preload the wallpaper
        hyprctl hyprpaper preload "$random_wallpaper"
        if [ $? -ne 0 ]; then
            echo "Failed to preload wallpaper"
            exit 1
        fi

    hyprctl hyprpaper wallpaper " ,$random_wallpaper"
    ln -sf "$random_wallpaper" "$cache_dir/current_wallpaper.png"
    hyprctl reload
    rm -rf ~/.cache/wal
}

if [ "$current_mode" == "dark" ]; then
    # Switch to light mode

    # gtk theme
    gsettings set org.gnome.desktop.interface gtk-theme "theme-light"

    # switch wallpaper
    if [[ "$engine" == "swww" ]]; then
        set_random_wallpaper_swww "$wallpaper_dir_light"
    elif [[ "$engine" == "hyprpaper" ]]; then
        set_random_wallpaper_hyprpaper "$wallpaper_dir_light"
    fi
    echo "light" > "$mode_file"
else
    # Switch to dark mode

    # gtk theme
    gsettings set org.gnome.desktop.interface gtk-theme "theme"

    # switch wallpaper
    if [[ "$engine" == "swww" ]]; then
        set_random_wallpaper_swww "$wallpaper_dir_dark"
    elif [[ "$engine" == "hyprpaper" ]]; then
        set_random_wallpaper_hyprpaper "$wallpaper_dir_dark"
    fi
    echo "dark" > "$mode_file"
fi

sleep 0.5
"$scripts_dir/pywal.sh"
sleep 0.2
"$scripts_dir/Refresh.sh"

mkdir -p "$cache_dir"
if [ -d "$cache_dir" ]; then
    convert "$cache_dir/current_wallpaper.png" -blur 0x20 -resize 100% "$cache_dir/blurred.png"
    notify-send -e " " "Created a blurred version of your Wallpaper"
fi


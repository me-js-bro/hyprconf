#!/bin/bash

mode_file="$HOME/.config/hypr/.cache/.mode"
scripts_dir="$HOME/.config/hypr/scripts"
wallpaper_dir="$HOME/.config/hypr/Wallpaper"
wallpaper="$HOME/.config/hypr/.cache/current_wallpaper.png"
engine_path="$HOME/.config/hypr/.cache/.engine"
monitor_config="$HOME/.config/hypr/configs/monitor.conf"

engine=$(cat $engine_path)

# Transition config
FPS=60
TYPE="any"
DURATION=2
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

if [ ! -f "$mode_file" ]; then
    touch "$mode_file" && echo "light" >> "$mode_file"
    "$scripts_dir/toggle_dark_light.sh"
elif [ -f "$wallpaper" ]; then

    if [[ "$engine" == "swww" ]] then

        swww query || swww init && swww img ${wallpaper} $SWWW_PARAMS
        
    elif [[ "$engine" == "hyprpaper" ]]; then

        # Ensure hyprpaper is running
        if ! pgrep -x hyprpaper > /dev/null; then
        hyprpaper -c ~/.config/hypr/hyprpaper.conf &
        sleep 1  # give hyprpaper some time to start
        fi

        hyprctl hyprpaper preload "$wallpaper"
        sleep 0.5
        hyprctl hyprpaper wallpaper " ,$wallpaper"
        hyprctl reload
        
        rm -rf ~/.cache/wal
        
    fi
else
    "$scripts_dir/Wallpaper.sh"
fi

# if openbangla keyboard is installed, the
if [[ -d "/usr/share/openbangla-keyboard" ]]; then
    fcitx5 &
fi

"$scripts_dir/notification.sh" sys
"$scripts_dir/pywal.sh"
"$scripts_dir/Refresh.sh"
"$scripts_dir/system.sh" run &

#_____ setup monitor

monitor_setting=$(cat $monitor_config | grep "monitor")
if [[ "$monitor_setting" == "monitor=,preferred,auto,auto" ]]; then
    notify-send "Starting script" "S script to setup monitor configuration"
    kitty --title monitor sh -c "$scripts_dir/monitor.sh"
fi

sleep 3

"$scripts_dir/default_browser.sh"

#!/bin/bash

scripts_dir="$HOME/.config/hypr/scripts"
wallpaper_dir="$HOME/.config/hypr/Wallpaper"
wallpaper="$HOME/.config/hypr/.cache/current_wallpaper.png"
engine_path="$HOME/.config/hypr/.cache/.engine"
monitor_config="$HOME/.config/hypr/configs/monitor.conf"

engine=$(cat $engine_path)
nightlight_value=$(cat "$HOME/.config/hypr/.cache/.nightlight")

# Transition config
FPS=60
TYPE="any"
DURATION=2
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

if [ -f "$wallpaper" ]; then

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
    fi
else
    "$scripts_dir/Wallpaper.sh"
fi

# if openbangla keyboard is installed, the
if [[ -d "/usr/share/openbangla-keyboard" ]]; then
    fcitx5 &> /dev/null
fi


"$scripts_dir/notification.sh" sys
"$scripts_dir/wallcache.sh"
"$scripts_dir/pywal.sh"
"$scripts_dir/system.sh" run &


#_____ setup monitor ( updated teh monitor.conf for the high resolution and higher refresh rate )

# monitor_setting=$(cat $monitor_config | grep "monitor")
# monitor_icon="$HOME/.config/hypr/icons/monitor.png"
# if [[ "$monitor_setting" == "monitor=,preferred,auto,auto" ]]; then
#     notify-send -i "$monitor_icon" "Monitor Setup" "A popup for your monitor configuration will appear within 5 seconds." && sleep 5
#     kitty --title monitor sh -c "$scripts_dir/monitor.sh"
# fi
#
# sleep 3

"$scripts_dir/default_browser.sh"

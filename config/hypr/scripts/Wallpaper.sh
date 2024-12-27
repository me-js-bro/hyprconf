#!/bin/bash

mode_file="$HOME/.config/hypr/.cache/.mode"
scripts_dir="$HOME/.config/hypr/scripts"
cache_dir="$HOME/.config/hypr/.cache"
engine_file="$cache_dir/.engine"
wallCache="$cache_dir/.wallpaper"
engine=$(cat "$engine_file")

[[ ! -f "$wallCache" ]] && touch "$wallCache"

if [[ "$engine" == "swww" ]]; then

    if [ ! -f "$mode_file" ]; then
        "$scripts_dir"/toggle_dark_light.sh
    else
        current_mode=$(cat "$mode_file")
        if [ "$current_mode" = "light" ]; then
            wallpaper_dir="$HOME/.config/hypr/Dynamic-Wallpapers/light"
        elif [ "$current_mode" = "dark" ]; then
            wallpaper_dir="$HOME/.config/hypr/Dynamic-Wallpapers/dark"
        fi

        PICS=($(find ${wallpaper_dir} -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))
        wallpaper=${PICS[ $RANDOM % ${#PICS[@]} ]}


        # Transition config
        FPS=60
        TYPE="any"
        DURATION=2
        BEZIER=".43,1.19,1,.4"
        SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

        notify-send -i "${wallpaper}" "Changing wallpaper."
        swww query || swww init && swww img ${wallpaper} $SWWW_PARAMS

        ln -sf "$wallpaper" "$cache_dir/current_wallpaper.png"

        baseName="$(basename $wallpaper)"
        wallName=${baseName%.*}
        echo "$wallName" > "$wallCache"

        if [[ ! -d "$HOME/.config/hypr/.cache/${wallName}-colors" ]]; then 
            if [[ "$current_mode" == "light" ]]; then
                wal -l -i "$wallpaper"
                elif [[ "$current_mode" == "dark" ]]; then
                wal -i "$wallpaper"
            fi
            cp -r "$HOME/.cache/wal" "$HOME/.config/hypr/.cache/${wallName}-colors"
        fi
        rm -rf "$HOME/.cache/wal"

    fi
elif [[ "$engine" == "hyprpaper" ]]; then

    if [ ! -f "$mode_file" ]; then
        "$scripts_dir"/toggle_dark_light.sh
    else
        current_mode=$(cat "$mode_file")
        if [ "$current_mode" = "light" ]; then
            wallpaper_dir="$HOME/.config/hypr/Dynamic-Wallpapers/light"
        elif [ "$current_mode" = "dark" ]; then
            wallpaper_dir="$HOME/.config/hypr/Dynamic-Wallpapers/dark"
        fi
        # Get a random wallpaper from the directory
        wallpaper=$(find "$wallpaper_dir" -type f | shuf -n 1)

        # Check if a wallpaper was found
        if [ -z "$wallpaper" ]; then
        echo "No wallpapers found in $wallpaper_dir"
        exit 1
        fi

        # Ensure hyprpaper is running
        if ! pgrep -x hyprpaper > /dev/null; then
        hyprpaper -c ~/.config/hypr/hyprpaper.conf &
        sleep 2  # give hyprpaper some time to start
        fi

        # Preload the wallpaper
        hyprctl hyprpaper preload "$wallpaper"
        if [ $? -ne 0 ]; then
        echo "Failed to preload wallpaper"
        exit 1
        fi

        # Set the wallpaper using hyprpaper
        notify-send -i "$wallpaper" "Changing wallpaper"
        hyprctl hyprpaper wallpaper " ,$wallpaper"
        ln -sf "$wallpaper" "$cache_dir/current_wallpaper.png"
        
        baseName="$(basename $wallpaper)"
        wallName=${baseName%.*}
        echo "$wallName" > "$wallCache"

        if [[ ! -d "$HOME/.config/hypr/.cache/${wallName}-colors" ]]; then 
            if [[ "$current_mode" == "light" ]]; then
                wal -q -l -i "$wallpaper"
                elif [[ "$current_mode" == "dark" ]]; then
                wal -q -i "$wallpaper"
            fi
            cp -r "$HOME/.cache/wal" "$HOME/.config/hypr/.cache/${wallName}-colors"
        fi
        rm -rf "$HOME/.cache/wal"

        hyprctl reload
        if [ $? -ne 0 ]; then
        echo "Failed to set wallpaper"
        exit 1
        fi

    fi
fi


sleep 0.5
"$scripts_dir/pywal.sh"
"$scripts_dir/wallcache.sh"
sleep 0.2
"$scripts_dir/Refresh.sh"

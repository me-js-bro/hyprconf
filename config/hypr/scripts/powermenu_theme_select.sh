#!/bin/bash

# Directory containing the style files
styles_dir="$HOME/.config/rofi/power_option"
window_rules="$HOME/.config/hypr/configs/wrules.conf"

# rofi them
theme="$HOME/.config/rofi/themes/conf-powertheme.rasi"

# # Path to the script where the selected theme is saved
menu_select_script="$HOME/.config/hypr/scripts/powermenu.sh"

# Get a list of style files
style_files=($(ls "$styles_dir"/*.rasi))

# Extract only the file names for display
style_names=("${style_files[@]##*/}")

# Present the list of styles using Rofi and get the selected style
selected_style=$(printf "%s\n" "${style_names[@]}" | rofi -dmenu -config "$theme" "Select Rofi theme")

# If a selection was made, apply the new style
if [ -n "$selected_style" ]; then
    selected_style_path="$styles_dir/$selected_style"
    # Update the menu_select.sh script with the selected theme
    sed -i "s|^theme=.*|theme='${selected_style%.rasi}'|" "$menu_select_script"
    notify-send -t 3000 "Power menu" "Theme applied: ${selected_style}"

    if [[ "$selected_style" == "fullscreen.rasi" ]]; then
        # enabling rofi blur
        sed -i "/^#layerrule = blur,rofi$/ s/#//" "$window_rules"
        sed -i "/^#layerrule = blur,rofi$/d" "$window_rules"
    else
        sed -i "/^layerrule = blur,rofi$/ s/^/#/" "$window_rules"
    fi
fi

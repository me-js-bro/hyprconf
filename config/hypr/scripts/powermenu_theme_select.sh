#!/bin/bash

# rofi them
theme="$HOME/.config/rofi/themes/rofi-powertheme.rasi"

# # Path to the script where the selected theme is saved
menu_select_script="$HOME/.config/hypr/scripts/powermenu.sh"

# Function to display the prompt
prompt() {
    echo "fullscreen"
    echo "small"
}

rofi_command="rofi -i -dmenu -config $theme"

# Present the list of styles using Rofi and get the selected style
selected_style=$(prompt | ${rofi_command})

if [ -n "$selected_style" ]; then
    sed -i "s|^theme=.*|theme='${selected_style%.rasi}'|" "$menu_select_script"
    notify-send -t 3000 "Power menu" "Theme applied: ${selected_style}"
fi

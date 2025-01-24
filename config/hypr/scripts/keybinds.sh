#!/bin/bash

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

# Define the config files
keybinds_config="$HOME/.config/hypr/configs/keybinds.conf"

# Combine the contents of the keybinds files and filter for keybinds
keybinds=$(cat "$keybinds_config" | grep -E '^(bind|bindl|binde|bindm)')

if [[ -z "$keybinds" ]]; then
    echo -e ">< No keybinds found."
    exit 1
fi

# Use rofi to display the keybinds
echo "$keybinds" | rofi -dmenu -i -p "Keybinds" -config ~/.config/rofi/themes/rofi-keybinds.rasi

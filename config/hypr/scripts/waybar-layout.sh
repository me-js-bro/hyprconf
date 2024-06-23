#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Define directories
waybar_layouts="$HOME/.config/waybar/configs"
waybar_config="$HOME/.config/waybar/config"
waybar_styles="$HOME/.config/waybar/style"
waybar_style="$HOME/.config/waybar/style.css"
script_dir="$HOME/.config/hypr/scripts"
window_rules="$HOME/.config/hypr/configs/environment.conf"
rofi_config="$HOME/.config/rofi/themes/rofi-waybar.rasi"
environment_config="$HOME/.config/hypr/configs/environment.conf"

# Function to display menu options
menu() {
    options=()
    while IFS= read -r file; do
        options+=("$(basename "$file")")
    done < <(find "$waybar_layouts" -maxdepth 1 -type f -exec basename {} \; | sort)

    printf '%s\n' "${options[@]}"
}

# Apply selected configuration
apply_config() {
    layout_file="$waybar_layouts/$1"
    style_file="$waybar_styles/$1.css"

    echo "Linking $layout_file to $waybar_config"
    echo "Linking $style_file to $waybar_style"

    ln -sf "$layout_file" "$waybar_config"
    ln -sf "$style_file" "$waybar_style"

    if [[ "$1" == "fancy-top" || "$1" == "fancy-bottom" || "$1" == "colorful-bottom" || "$1" == "colorful-top" || "$1" == "full-top-1" || "$1" == "full-bottom-1" ]]; then
        echo "Enabling blur in $window_rules"
        sed -i "/^#blurls = waybar$/ s/#//" "$window_rules"
        sed -i "/^#blurls = waybar$/d" "$window_rules"
    else
        echo "Disabling blur in $window_rules"
        sed -i "/^blurls = waybar$/ s/^/#/" "$window_rules"
    fi

    restart_waybar_if_needed
}

# Restart Waybar
restart_waybar_if_needed() {
    if pgrep -x "waybar" >/dev/null; then
        echo "Restarting Waybar"
        killall waybar
        sleep 0.1  # Delay for Waybar to completely terminate
    fi
    "$script_dir/Refresh.sh"
}

# Main function
main() {
    choice=$(menu | rofi -dmenu -config "$rofi_config")

    if [[ -z "$choice" ]]; then
        echo "No option selected. Exiting."
        exit 0
    fi

    case $choice in
        *)
            apply_config "$choice"
            ;;
    esac
}

if pgrep -x "rofi" >/dev/null; then
    pkill rofi
    exit 0
fi

main

"${script_dir}/Refresh.sh"

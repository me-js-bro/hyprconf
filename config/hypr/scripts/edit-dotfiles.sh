#!/bin/bash
# Rofi menu for Quick Edit / View of Settings (SUPER E)

hypr_dir="$HOME/.config/hypr"
hypr_configs="$hypr_dir/configs"
scripts="$hypr_dir/scripts"
rofi="$HOME/.config/rofi"
swaync="$HOME/.config/swaync"
waybar="$HOME/.config/waybar"

menu(){
  printf "1. Edit Hyprland Configs\n"
  printf "2. Edit Scripts\n"
  printf "3. Edit Rofi\n"
  printf "4. Edit Swaync\n"
  printf "5. Edit Waybar\n"
}

notify() {
    if [ -n "$(command -v code)" ]; then
        notify-send "$1" "Opening with VS Code"
        editor="code"
    elif [ -n "$(command -v nvim)" ]; then
        notify-send "$1" "Opening with Neovim"
        editor="nvim"
    else
        notify-send "$1" "Opening with Nano"
        editor="nano"  # Default to nano if neither VS Code nor Neovim is found
    fi
}

main() {
    notify "Starting Editor"
    choice=$(menu | rofi -dmenu -config ~/.config/rofi/themes/rofi-edit-dots.rasi | cut -d. -f1)
    case $choice in
        1)
            $editor $hypr_configs
            ;;
        2)
            $editor $scripts
            ;;
        3)
            $editor $rofi
            ;;
        4)
            $editor $swaync
            ;;
        5)
            $editor $waybar
            ;;
        *)
            notify-send "...." "No config found"
            ;;
    esac
}

main

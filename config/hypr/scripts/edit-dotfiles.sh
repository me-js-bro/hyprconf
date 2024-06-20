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
  printf "5. Edit Swaync\n"
  printf "6. Edit Waybar\n"
}

if dnf list installed code &>> /dev/null; then
    editor="code"
else
    notify-send "Opening with Neovim"

    editor="nvim"
fi

main() {
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
            ;;
        4)
            $editor $swaync
            ;;
        5)
            $editor $waybar
            ;;
        6)
            $editor $wlogout
            ;;
        *)
            ;;
    esac
}

main
#!/bin/bash

# Script for setting window border width and roundness.
hyprconf_setting="$HOME/.config/hypr/configs/decoration.conf"
dunst="$HOME/.config/dunst/dunstrc"


# gum function to choose multiple settings
printf "[ * ]\nChoose which settings you want to change (_multiple_selection by pressing space_)..\n"
_hyprland_choice=$(gum choose --no-limit "border_size" "roundness" "inner_gap" "outer_gap" "blur" "cancel")

# Convert the newline-separated string into an array
IFS=$'\n' read -rd '' -a primary_choice <<<"$_hyprland_choice"
IFS=$'\n' read -rd '' -a _swaync_primary <<<"$_swaync_choice"

# Exit if "cancel" is chosen
if [[ -n "$_hyprland_choice" && "${primary_choice[*]}" =~ "cancel" ]]; then
    exit 1
fi

# Loop through each chosen setting
for user_choice in "${primary_choice[@]}"; do
    clear
    case "$user_choice" in
    "border_size")
        printf "\n[ <> ]\nSetting border size...\n\n"
        border_size=$(gum input --placeholder "Type border width you want (in numbers)...")
        while ! [[ "$border_size" =~ ^[0-9]+$ ]]; do
            printf "Invalid input. Please enter a number.\n"
            border_size=$(gum input --placeholder "Type border width you want (in numbers)...")
        done
        sed -i "s/border_size = .*/border_size = $border_size/g" "$hyprconf_setting"
        sed -i "s/frame_width = .*/frame_width = $border_size/g" "$dunst"
        ;;
    "roundness")
        printf "\n[ <> ]\nSetting border roundness...\n\n"
        rounding=$(gum input --placeholder "Type border roundness you want (in numbers)...")
        while ! [[ "$rounding" =~ ^[0-9]+$ ]]; do
            printf "Invalid input. Please enter a number.\n"
            rounding=$(gum input --placeholder "Type border roundness you want (in numbers)...")
        done
        sed -i "s/rounding = .*/rounding = $rounding/g" "$hyprconf_setting"
        sed -i "s/^[[:space:]]*corner_radius[[:space:]]*= .*/corner_radius = $rounding/g" "$dunst"
        ;;
    "inner_gap")
        printf "\n[ <> ]\nSetting inner gap...\n\n"
        gaps_in=$(gum input --placeholder "Type the inner gap you want (in numbers)...")
        while ! [[ "$gaps_in" =~ ^[0-9]+$ ]]; do
            printf "Invalid input. Please enter a number.\n"
            gaps_in=$(gum input --placeholder "Type the inner gap you want (in numbers)...")
        done
        sed -i "s/gaps_in = .*/gaps_in = $gaps_in/g" "$hyprconf_setting"
        ;;
    "outer_gap")
        printf "\n[ <> ]\nSetting outer gap...\n\n"
        gaps_out=$(gum input --placeholder "Type the outer gap you want (in numbers)...")
        while ! [[ "$gaps_out" =~ ^[0-9]+$ ]]; do
            printf "Invalid input. Please enter a number.\n"
            gaps_out=$(gum input --placeholder "Type the outer gap you want (in numbers)...")
        done
        sed -i "s/gaps_out = .*/gaps_out = $gaps_out/g" "$hyprconf_setting"
        ;;
    "blur")
        printf "\n[ <> ]\nSetting blur...\n\n"
        blur_size=$(gum input --placeholder "Type the amount of blur size you want (in numbers)...")
        while ! [[ "$blur_size" =~ ^[0-9]+$ ]]; do
            printf "Invalid input. Please enter a number.\n"
            blur_size=$(gum input --placeholder "Type the amount of blur size you want (in numbers)...")
        done
        blur_passes=$(gum input --placeholder "Type the amount of blur passes you want (in numbers)...")
        while ! [[ "$blur_passes" =~ ^[0-9]+$ ]]; do
            printf "Invalid input. Please enter a number.\n"
            blur_passes=$(gum input --placeholder "Type the amount of blur passes you want (in numbers)...")
        done
        sed -i "/^[^_]*size = .*/s/size = .*/size = $blur_size/" "$hyprconf_setting"
        sed -i "s/passes = .*/passes = $blur_passes/" "$hyprconf_setting"
        ;;
    *)
        echo "Invalid choice: $user_choice"
        ;;
    esac
done

# Reload Hyprland
printf "\n[ ** ] Reloading Hyprland configuration...\n"
killall dunst
hyprctl reload

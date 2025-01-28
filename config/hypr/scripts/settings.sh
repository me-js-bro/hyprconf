#!/bin/bash

display() {
    cat << EOF
            ╔═╗┬ ┬┌─┐┌┐┌┌─┐┌─┐  ╔═╗┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐┌─┐            
            ║  ├─┤├─┤││││ ┬├┤   ╚═╗├┤  │  │ │││││ ┬└─┐            
────────────╚═╝┴ ┴┴ ┴┘└┘└─┘└─┘  ╚═╝└─┘ ┴  ┴ ┴┘└┘└─┘└─┘────────────
EOF
}

# Script for setting window border width and roundness.
hyprconf_setting="$HOME/.config/hypr/configs/decoration.conf"
dunst="$HOME/.config/dunst/dunstrc"


# gum function to choose multiple settings
display
printf "\n  => Choose which settings you want to change\n  -> Need to select using the space bar\n"
echo
_hyprland_choice=$(gum choose --header "Select settings:" --no-limit "border_size" "roundness" "inner_gap" "outer_gap" "blur" "cancel")

# Convert the newline-separated string into an array
IFS=$'\n' read -rd '' -a primary_choice <<<"$_hyprland_choice"
IFS=$'\n' read -rd '' -a _swaync_primary <<<"$_swaync_choice"

# Exit if "cancel" is chosen
if [[ -n "$_hyprland_choice" && "${primary_choice[*]}" =~ "cancel" ]]; then
    exit 0
fi

# Loop through each chosen setting
for user_choice in "${primary_choice[@]}"; do
    clear
    case "$user_choice" in
    "border_size")
        printf "\n[ <> ]\nSetting border size...\n\n"
        border_size=$(gum input --placeholder "Type border width...")
        while ! [[ "$border_size" =~ ^[0-9]+$ ]]; do
            printf "Invalid input. Please enter a number.\n"
            border_size=$(gum input --placeholder "Type border width...")
        done
        sed -i "s/border_size = .*/border_size = $border_size/g" "$hyprconf_setting"
        sed -i "s/frame_width = .*/frame_width = $border_size/g" "$dunst"
        ;;
    "roundness")
        printf "\n[ <> ]\nSetting border roundness...\n\n"
        rounding=$(gum input --placeholder "Type border roundness...")
        while ! [[ "$rounding" =~ ^[0-9]+$ ]]; do
            printf "Invalid input. Please enter a number.\n"
            rounding=$(gum input --placeholder "Type border roundness...")
        done
        sed -i "s/rounding = .*/rounding = $rounding/g" "$hyprconf_setting"
        sed -i "s/^[[:space:]]*corner_radius[[:space:]]*= .*/corner_radius = $rounding/g" "$dunst"
        ;;
    "inner_gap")
        printf "\n[ <> ]\nSetting inner gap...\n\n"
        gaps_in=$(gum input --placeholder "Type the inner gap...")
        while ! [[ "$gaps_in" =~ ^[0-9]+$ ]]; do
            printf "Invalid input. Please enter a number.\n"
            gaps_in=$(gum input --placeholder "Type the inner gap...")
        done
        sed -i "s/gaps_in = .*/gaps_in = $gaps_in/g" "$hyprconf_setting"
        ;;
    "outer_gap")
        printf "\n[ <> ]\nSetting outer gap...\n\n"
        gaps_out=$(gum input --placeholder "Type the outer gap...")
        while ! [[ "$gaps_out" =~ ^[0-9]+$ ]]; do
            printf "Invalid input. Please enter a number.\n"
            gaps_out=$(gum input --placeholder "Type the outer gap...")
        done
        sed -i "s/gaps_out = .*/gaps_out = $gaps_out/g" "$hyprconf_setting"
        ;;
    "blur")
        printf "\n[ <> ]\nSetting blur...\n\n"
        blur_size=$(gum input --placeholder "Type the amount of blur size...")
        while ! [[ "$blur_size" =~ ^[0-9]+$ ]]; do
            printf "Invalid input. Please enter a number.\n"
            blur_size=$(gum input --placeholder "Type the amount of blur size...")
        done
        blur_passes=$(gum input --placeholder "Type the amount of blur passes...")
        while ! [[ "$blur_passes" =~ ^[0-9]+$ ]]; do
            printf "Invalid input. Please enter a number.\n"
            blur_passes=$(gum input --placeholder "Type the amount of blur passes...")
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
printf "\n[ ** ] Reloading Hyprland configuration...\n" && sleep 1
killall dunst
hyprctl reload

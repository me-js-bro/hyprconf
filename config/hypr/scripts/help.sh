#!/bin/bash

# took and modified from JaKooLit #

# Detect monitor resolution and scale
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

# Calculate width and height based on percentages and monitor resolution
width=$((x_mon * hypr_scale / 100))
height=$((y_mon * hypr_scale / 100))

# Set maximum width and height
max_width=1200
max_height=1000

# Set percentage of screen size for dynamic adjustment
percentage_width=70
percentage_height=70

# Calculate dynamic width and height
dynamic_width=$((width * percentage_width / 100))
dynamic_height=$((height * percentage_height / 100))

# Limit width and height to maximum values
dynamic_width=$(($dynamic_width > $max_width ? $max_width : $dynamic_width))
dynamic_height=$(($dynamic_height > $max_height ? $max_height : $dynamic_height))

# Launch yad with calculated width and height
yad --width=$dynamic_width --height=$dynamic_height \
    --center \
    --title="Keybindings" \
    --no-buttons \
    --list \
    --column=Key: \
    --column=Description: \
    --column=Command: \
    --timeout-indicator=bottom \
" = " "SUPER KEY (Windows Key)" "(SUPER KEY)" \
"" "" "" \
" + k" "Terminal" "(Kitty  )" \
" + + D" "App Launcher" "(Rofi)" \
" + SHIFT + D" "Emoji Selector" "(Rofi)" \
" + SHIFT + F" "FilrBrowser" "(Rofi)" \
" + E" "Open File Manager" "(Thunar)" \
" + SHIFT + E" "Open File Manager" "(Dolphin)" \
" + CTRL + E" "Choose to edit dotfiles" "(Rofi)" \
" + Q" "close active window" "(not kill)" \
" + ALT + C" "Clipboard Manager" "(Cliphist)" \
" + ALT + W" "Clear Clipboard History" "(Cliphist)" \
" + W" "Change wallpaper (Random)" "(Swww)" \
" + SHIFT + W" "Select wallpaper" "(Rofi)" \
" + CTRL + W" "Select Waybar Layout" "(Rofi)" \
" + B" "Browser" "(Firefox 󰈹 )" \
" + SHIFT + B" "Browser" "(Brave, if installed)" \
" + C" "Code Editor" "(Visual Studio Code 󰨞 )" \
" " "Print" "Screenshot" "(Grimblast)" \
" + Print" "Screenshot region" "(Grimblast)" \
" + X" "Power-menu" "(Wlogout)" \
" + SHIFT + L" "Screen lock" "(Swaylock)" \
" + F" "Fullscreen" "(Toggles full-screen)" \
" + V" "Floating" "(Toggle floating window)" \
" + H" " " "Launch this app" \
" + P" "Toggle Keyboard" "Ibus (Bangla & English)" \
"" "" "" \
"F9" "Volume" "(Volume Mute  )" \
"F10" "Volume" "(Volume Decrease  )" \
"F11" "Volume" "(Volume Increase  )" \
"" "" "" \
"CTRL + ESC" " " "Reload Waybar" \





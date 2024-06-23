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
" + Return" "Terminal" "(Alacritty)" \
" + E" "Open File Manager" "(Thunar)" \
"" "" "" \
" + D" "App Launcher" "(Rofi)" \
" + Alt + D" "App Launcher Theme" "(Rofi)" \
" + SHIFT + D" "Emoji Selector" "(Rofi)" \
" + x" "Power Menu" "(Rofi)" \
" + Alt + x" "Power Menu Theme" "(Rofi)" \
" + Alt + b" "Shell (zsh/bash) Theme" "(Rofi)" \
" + CTRL + E" "Choose to edit dotfiles" "(Rofi)" \
" + SHIFT + W" "Select wallpaper" "(Rofi)" \
" + Alt + SHIFT + W" "Select wallpaper (style-2)" "(Rofi)" \
" + ALT + C" "Clipboard Manager" "(Cliphist (Rofi))" \
" + ALT + W" "Clear Clipboard History" "(Cliphist (Rofi))" \
" + CTRL + W" "Select Waybar Layout" "(Rofi)" \
"" "" "" \
" + Q" "close active window" "(not kill)" \
"" "" "" \
" + W" "Change wallpaper (Random)" "(Swww)" \
" + B" "Browser" "(Brave/Chromium)" \
" + SHIFT + B" "Browser" "(Firefox 󰈹 )" \
" + C" "Code Editor" "(Visual Studio Code 󰨞 )" \
" " "Print" "Screenshot" "(Grimblast)" \
" + Print" "Screenshot region" "(Grimblast)" \
" + SHIFT + L" "Screen lock" "(hyprlock)" \
" + F" "Fullscreen" "(Toggles full-screen)" \
" + V" "Floating" "(Toggle floating window)" \
" + H" " " "Launch this app" \
"CTRL + Space" "Toggle Keyboard" "fcitx5 (Bangla & English)" \
"" "" "" \
"F9" "Volume" "(Volume Mute  )" \
"F10" "Volume" "(Volume Decrease  )" \
"F11" "Volume" "(Volume Increase  )" \
"" "" "" \
"F2" "Brightness" "(Brightness Increase  )" \
"F3" "Brightness" "(Brightness Decrease  )" \
"" "" "" \
"CTRL + ESC" " " "Hide/Launch Waybar" \
"CTRL+ Alt + ESC" " " "Reload Waybar" \
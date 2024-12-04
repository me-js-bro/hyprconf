#!/bin/bash

config_file="$HOME/.config/hypr/configs/monitor.conf"
auto_generated_setting=$(cat $config_file | grep "monitor=,preferred,auto,auto")

if [[ "$auto_generated_setting" ]]; then

    gum spin --spinner minidot \
        --title "Setting up for your Monitor" -- \
        sleep 1

    monitor_name=$(xrandr | grep "connected" | awk '{print $1}')
    monitor_resolution=$(xrandr | grep "connected" | awk '{print $3}' | cut -d'+' -f1)

    printf "[ ? ]\n==> What is your Monitor refresh rate?\n"
    refresh_rate=$(gum choose "60Hz" "75Hz" "120Hz" "144Hz" "165Hz" "180Hz" "200Hz" "240Hz")

    case $refresh_rate in
        60Hz)
            settings="monitor=${monitor_name},${monitor_resolution}@60, 0x0, 1"
            ;;
        75Hz)
            settings="monitor=${monitor_name},${monitor_resolution}@75, 0x0, 1"
            ;;
        120Hz)
            settings="monitor=${monitor_name},${monitor_resolution}@120, 0x0, 1"
            ;;
        144Hz)
            settings="monitor=${monitor_name},${monitor_resolution}@144, 0x0, 1"
            ;;
        165Hz)
            settings="monitor=${monitor_name},${monitor_resolution}@165, 0x0, 1"
            ;;
        180Hz)
            settings="monitor=${monitor_name},${monitor_resolution}@165, 0x0, 1"
            ;;
        200Hz)
            settings="monitor=${monitor_name},${monitor_resolution}@200, 0x0, 1"
            ;;
        240Hz)
            settings="monitor=${monitor_name},${monitor_resolution}@240, 0x0, 1"
            ;;
    esac

    sed -i "s/$auto_generated_setting/$settings/" "$config_file"

else
    current=$(cat $config_file | grep "monitor")
    printf "[ * ] ==> Monitor is already configured to '$current'\n"
fi

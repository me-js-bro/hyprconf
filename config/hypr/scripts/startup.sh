#!/bin/bash

scripts_dir="$HOME/.config/hypr/scripts"
monitor_config="$HOME/.config/hypr/configs/monitor.conf"

# if openbangla keyboard is installed, the
if [[ -d "/usr/share/openbangla-keyboard" ]]; then
    fcitx5 &
fi

"$scripts_dir/notification.sh" sys
"$scripts_dir/wallcache.sh"
"$scripts_dir/pywal.sh"
"$scripts_dir/system.sh" run &

#_____ setup monitor

monitor_setting=$(cat $monitor_config | grep "monitor")
if [[ "$monitor_setting" == "monitor=,preferred,auto,auto" ]]; then
    notify-send -t 3000 "Starting script" "S script to setup monitor configuration"
    kitty --title monitor sh -c "$scripts_dir/monitor.sh"
fi

sleep 3

"$scripts_dir/default_browser.sh"

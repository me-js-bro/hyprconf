#!/bin/bash

browser_cache="$HOME/.config/hypr/.cache/browser"
scripts_dir="$HOME/.config/hypr/scripts"

[[ ! -f "$browser_cache" ]] && touch "$browser_cache"

# List of browsers to check.
browsers=("firefox" "brave" "brave-browser" "Brave-browser" "chromium-browser" "Chromium-browser" "google-chrome")

# Loop through the list and append found browsers to the cache.
for browser in "${browsers[@]}"; do
    if command -v "$browser" &>/dev/null && ! grep -qx "$browser" "$browser_cache"; then
        echo "Found: $browser"
        echo "$browser" >> "$browser_cache"
    fi
done

browsers_num=$(grep -v -n "default" "$browser_cache" | wc -l)
default=$(grep "default=" "$browser_cache" | awk -F'=' '{print $2}')

if [[ "$browsers_num" -gt 1 && -z "$default" ]]; then
    notify-send "Missing Default Browser" "You need to set a default browser. Opening kitty to set a default browser." && sleep 5
    kitty --title browser sh -c "$scripts_dir/browser.sh ch"
elif [[ "$browsers_num" -eq 1 && -z "$default" ]]; then
    existing=$(grep -v "default=" "$browser_cache")
    notify-send "Default browser" "Setting $existing as your default browser."
    echo "default=$existing" >> "$browser_cache"
fi

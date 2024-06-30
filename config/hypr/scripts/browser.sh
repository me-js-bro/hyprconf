#!/bin/bash

# finding the browse to open with --enable-wayland-ime 

# browser location
if [[ -f "/usr/bin/brave" ]]; then
    browser="brave"

elif [[ -f "/usr/bin/brave-browser" ]]; then
    browser="brave-browser"

elif [[ -f "/usr/bin/chromium" ]]; then
    browser="chromium"

elif [[ -f "/usr/bin/chromium-browser" ]]; then
    browser="chromium-browser"
    
fi

# function to open browser

open_browser() {
    case $1 in
        open)
            "$browser" --enable-wayland-ime
            ;;
        *) 
            notify-send -e "Sorry" "Browser is not installed"
            ;;
    esac
}

open_browser "$1"
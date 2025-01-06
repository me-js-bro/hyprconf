#!/bin/bash

case $1 in
    fb)
        url="https://www.facebook.com"
        ;;
    yt)
        url="https://www.youtube.com"
        ;;
    ai)
        url="https://chat.openai.com"
        ;;
    gem)
        url="https://gemini.google.com/app"
        ;;
    wapp)
        url="https://web.whatsapp.com"
        ;;
    github)
        url="https://github.com"
        ;;
    ps)
        url="https://www.photopea.com/"
        ;;
    *)
        echo "Usage: $0 {fb|yt|ai|wapp|github}"
        exit 1
        ;;
esac

# Define the browsers in the order of preference
browser_cache="$HOME/.config/hypr/.cache/.browser"
browser=$(grep "default" "$browser_cache" | awk -F'=' '{print $2}')

# Loop through the browsers and try to open the URL with the first available one
if [[ ! "$browser" == "firefox" ]]; then
    "$browser" --app="$url"
elif [[ "$browser" == "firefox" || "$browser" == "zen-browser" ]]; then
    "$browser" --new-window "$url"
fi

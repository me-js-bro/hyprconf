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
if [[ -f "/usr/bin/brave" ]]; then
    browser="brave"
elif [[ -f "/usr/bin/brave-browser" ]]; then
    browser="brave-browser"
elif [[ -f "/usr/bin/chromium" ]]; then
    browser="chromium-browser"
fi

# Loop through the browsers and try to open the URL with the first available one
if command -v "$browser" &> /dev/null; then
    "$browser" --app="$url"
    # echo "$browser"
    exit 0
fi

# If no browser is found, display an error message
# echo "Error: No supported browser found."
# exit 1


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
browsers=("chromium-browser" "google-chrome" "brave-browser")

# Loop through the browsers and try to open the URL with the first available one
for browser in "${browsers[@]}"; do
    if command -v "$browser" &> /dev/null; then
        "$browser" --app="$url"
        exit 0
    fi
done

# If no browser is found, display an error message
echo "Error: No supported browser found."
exit 1


#!/bin/bash
# Wallpaper engine changing script (swww/hyprpaper)

scripts="$HOME/.config/hypr/scripts"
cache_dir="$HOME/.config/hypr/.cache"
engine="$cache_dir/.engine"
mkdir -p "$cache_dir"
touch "$engine"

# Function to display the prompt
prompt() {
    echo "swww"
    echo "hyprpaper"
}

rofi_command="rofi -i -dmenu -config ~/.config/rofi/themes/rofi-wall-engine.rasi"

# Main function
main() {
    choice=$(prompt | ${rofi_command})
    
    # Debugging: Output the choice to see what was selected
    echo "Selected choice: '$choice'"
    
    # If nothing is selected, exit without changing anything
    if [ -z "$choice" ]; then
        echo "No choice selected, exiting..."
        exit 0
    fi

    case "$choice" in
        "swww")
            echo "swww" > "$engine"
            killall hyprpaper
            ;;
        "hyprpaper")
            echo "hyprpaper" > "$engine"
            killall swww-daemon
            ;;
        *)
            echo "Invalid choice"
            exit 1
            ;;
    esac

    # Debugging: Output the content of the engine file
    echo "Engine set to: $(cat $engine)"
}

main && "$scripts/Wallpaper.sh"

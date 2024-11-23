#!/bin/bash

value_file="$HOME/.cache/.nightlight"
default=6000
notification_id_file=".nightlight_notify_id"

# Initialize the value file if it doesn't exist
if [[ ! -f "$value_file" ]]; then
    echo $default > $value_file
fi

value=$(cat $value_file)

# Initialize the notification ID file if it doesn't exist
if [[ ! -f "$notification_id_file" ]]; then
    echo 0 > $notification_id_file
fi

notification_id=$(cat $notification_id_file)

if command -v hyprsunset &> /dev/null; then
    fn_change_value() {
        case $1 in
            --inc)
                if (( value + 100 <= 6000 )); then
                    value=$((value + 100))
                    echo "$value" > "$value_file"
                    notification_id=$(notify-send -p -r "$notification_id" "Nightlight" "Screen temp: ${value}k")
                    echo "$notification_id" > "$notification_id_file"
                    hyprsunset -t "$value"
                else
                    notification_id=$(notify-send -p -r "$notification_id" "Nightlight Max Value" "Cannot increase more than ${value}k")
                    echo "$notification_id" > "$notification_id_file"
                fi
            ;;
            --dec)
                if (( value - 100 >= 3000 )); then
                    value=$((value - 100))
                    echo "$value" > "$value_file"
                    notification_id=$(notify-send -p -r "$notification_id" "Nightlight" "Screen temp: ${value}k")
                    echo "$notification_id" > "$notification_id_file"
                    hyprsunset -t "$value"
                else
                    notification_id=$(notify-send -p -r "$notification_id" "Nightlight Min Value" "Cannot decrease more than ${value}k")
                    echo "$notification_id" > "$notification_id_file"
                fi
            ;;
            --def)
                value=$default
                echo "$value" > "$value_file"
                notification_id=$(notify-send -p -r "$notification_id" "Nightlight" "Screen temp reset to default")
                echo "$notification_id" > "$notification_id_file"
                killall hyprsunset
            ;;
        esac
    }

    fn_change_value "$1"
else
    echo "hyprsunset command not found. Please install it or add it to your PATH."
fi

printf "${value}K"
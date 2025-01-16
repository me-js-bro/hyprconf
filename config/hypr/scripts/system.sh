#!/bin/bash

notified=false
while true; do

    #-----------------------------------------#
    #          Memory Usage Notify            #
    #-----------------------------------------#

    # memory usage
    total_mem=$(free -h | awk 'NR==2 {print $2}' | grep -oP '^[0-9]+(\.[0-9]+)?')
    total_int=$(printf "%.0f" "$total_mem")
    eighty_percent=$(( $total_int * 80 / 100 ))

    used_mem=$(free -h | awk 'NR==2 {print $3}' | grep -oP '^[0-9]+(\.[0-9]+)?')
    used_int=$(printf "%.0f" "$used_mem")

    if [[ "$used_int" -ge "$eighty_percent" ]]; then
        if [[ "$notified" == false ]]; then
            notify-send -u "critical" -i "$HOME/.config/hypr/icons/warning.png" "Warning!" "You have used your 80% of the memory. $used_mem GB is now in use"
            notified=true  # Set the flag to true after sending the notification
        fi
    else
        notified=false  # Reset the flag if memory usage drops below 80%
    fi



    #-----------------------------------------#
    #          NightLight Increasing          #
    #-----------------------------------------#

    # Get the current time in HHMM format (e.g., 2000, 2005)
    current_time=$(date +%H%M)
    value_file="$HOME/.config/hypr/.cache/.nightlight"
    default=6000
    min_value=4000
    step=285  # Decrease by 285K every 5 minutes

    # Initialize the value file if it doesn't exist
    if [[ ! -f "$value_file" ]]; then
        echo $default > "$value_file"
    fi

    value=$(cat "$value_file")

    # Function to decrease nightlight temperature by 285K
    decrease_temp() {
        if (( value - step >= min_value )); then
            value=$((value - step))
        else
            value=$min_value
        fi
        echo "$value" > "$value_file"
        hyprsunset -t "$value"
    }
    
    # Function to reset nightlight temperature to 6000K at 7:00 AM
    reset_temp() {
        value=$default
        echo "$value" > "$value_file"
        hyprsunset -t "$value"
        notify-send "Nightlight" "Reset to $value K for the day"
    }

    # Decrease temperature every 5 minutes between 2000 and 2030
    case "$current_time" in
        2000|2005|2010|2015|2020|2025|2030)
            decrease_temp
            ;;
        0700)
            reset_temp
            ;;
    esac

    sleep 5
done

case $1 in
    run)
        "$HOME/.config/hypr/scripts/system.sh"
        ;;
    kill)
        pkill -f "$HOME/.config/hypr/scripts/system.sh"
        ;;
esac

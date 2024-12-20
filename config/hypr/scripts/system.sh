#!/bin/bash

notified=false
while true; do
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

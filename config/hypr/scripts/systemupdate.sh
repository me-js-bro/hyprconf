#!/bin/bash

SOUND_FILE_UPDATE="$HOME/.config/hypr/sounds/update.wav"
SOUND_FILE_ERROR="$HOME/.config/hypr/sounds/error.wav"
update_sign="$HOME/.config/hypr/icons/update.png"
done_sign="$HOME/.config/hypr/icons/done.png"
warning_sign="$HOME/.config/hypr/icons/warning.png"
error_sign="$HOME/.config/hypr/icons/error.png"

# notification functions
update_notification() {
    notify-send -i "$1" "$2" "$3"
    paplay "$SOUND_FILE_UPDATE"
}

error_notification() {
    notify-send -i "$1" "$2" "$3"
    paplay "$SOUND_FILE_ERROR"
}

scripts_dir="$HOME/.config/hypr/scripts"

# for arch linux
if [ -f /etc/arch-release ]; then

    # Function to check for updates
    aurhlpr=$(command -v yay || command -v paru)
    check_for_updates() {
        aur=$(${aurhlpr} -Qua | wc -l)
        ofc=$(checkupdates | wc -l)

        # Calculate total available updates
        upd=$(( ofc + aur ))

        echo "$upd"
    }

    # tooltip in waybar
    aur=$(${aurhlpr} -Qua | wc -l)
    ofc=$(checkupdates | wc -l)

    # Initial check for updates
    upd=$(check_for_updates)

    # Show tooltip
    if [ $upd -eq 0 ] ; then
        echo "{\"text\":\"$upd\", \"tooltip\":\"  Packages are up to date\"}"
    else
        echo "{\"text\":\"$upd\", \"tooltip\":\"󱓽 Official $ofc\n󱓾 AUR $aur\"}"
        update_notification "$update_sign" "Updates Available: $upd" "Main: $ofc, Aur: $aur"
    fi

    # Function to update packages
    update_packages() {
        kitty --title systemupdate sh -c "${aurhlpr} -Syyu --noconfirm"
        upd=$?

        sleep 1

        if [ $upd -eq 0 ]; then
            update_notification "$done_sign" "Done" "Packages have been updated"
        elif [ $upd -gt 0 ]; then
            error_notification "$warning_sign" "Warning!" "Some packages may have skipped"
        else
            error_notification "$error_sign" "Error!" "Sorry, could not update packages"
        fi
    }

# for fedora
elif [ -f /etc/fedora-release ]; then

    # Calculate total available updates fedora
    upd=$(dnf check-update -q | wc -l)

    # Show tooltip
    if [ $upd -eq 0 ] ; then
        echo "{\"text\":\"$upd\", \"tooltip\":\"  Packages are up to date\"}"
        # "$scripts_dir/notification.sh" notify "  Packages are up to date"
    else
        echo "{\"text\":\"$upd\", \"tooltip\":\"󱓽 Updates Available: $upd\"}"
        update_notification "$update_sign" "Updates Available" "$upd packages"
    fi

    sleep 1

    update_packages() {
        # Run the update command and capture the return code
        kitty --title systemupdate sh -c "sudo dnf update -y && sudo dnf upgrade -y"
        upd=$?

        sleep 2

        if [ $upd -eq 0 ]; then
            update_notification "$done_sign" "Done" "Packages have been updated"
        elif [ $upd -gt 0 ]; then
            error_notification "$warning_sign" "Warning!" "Some packages may have skipped"
        else
            error_notification "$error_sign" "Error!" "Sorry, could not update packages"
        fi
}


# opensuse ( not sure if it works or not )
elif [ -f /etc/os-release ]; then

    source /etc/os-release
    if [[ $ID == "opensuse-tumbleweed" ]]; then

        # Count the number of available updates
        ofc=$(zypper lu --best-effort | grep -c 'v |')

        # Calculate total available updates
        upd=$(( ofc ))

        # Show tooltip
        if [ $upd -eq 0 ] ; then
            echo "{\"text\":\"$upd\", \"tooltip\":\"  Packages are up to date\"}"
            # "$scripts_dir/notification.sh" notify "  Packages are up to date"
        else
            echo "{\"text\":\"$upd\", \"tooltip\":\"󱓽 Updates Available: $upd\"}"
            update_notification "$update_sign" "Updates Available" "$upd packages"
        fi

        update_packages() {
            kitty --title systemupdate sh -c "sudo zypper up"
            $upd=$?
            sleep 2
                
            if ((upd == 0)); then
                update_notification "$done_sign" "Done" "Packages have been updated"
            elif ((upd > 0)); then
                error_notification "$warning_sign" "Warning!" "Some packages may have skipped"
            else
                error_notification "$error_sign" "Error!" "Sorry, could not update packages"
            fi
        }
    fi
fi

# Trigger upgrade
if [ "$1" == "up" ] ; then
    update_packages
    "$scripts_dir/Refresh.sh"
fi

#!/usr/bin/env bash

scripts_dir="$HOME/.config/hypr/scripts"

# for arch linux
if [ -f /etc/arch-release ]; then

    # Check for updates
    aurhlpr=$(command -v yay || command -v paru)
    aur=$(${aurhlpr} -Qua | wc -l)

    # Check for flatpak updates
    ofc=$(checkupdates | wc -l)

    # Calculate total available updates
    upd=$(( ofc + aur ))

    # Show tooltip
    if [ $upd -eq 0 ] ; then
        echo "{\"text\":\"$upd\", \"tooltip\":\"  Packages are up to date\"}"
        # "$scripts_dir/notification.sh" notify "  Packages are up to date"
    else
        echo "{\"text\":\"$upd\", \"tooltip\":\"󱓽 Official $ofc\n󱓾 AUR $aur$fpk_disp\"}"
        "$scripts_dir/notification.sh" notify "󱓽 Updates Available: $upd"
    fi

    update_packages() {
        alacritty --title systemupdate -e sh -c "${aurhlpr} -Syu $fpk_exup"

        sleep 3

        if [ $upd -eq 0 ] ; then
            "$scripts_dir/notification.sh" notify "  Packages updated successfully"
        else
            "$scripts_dir/notification.sh" notify "Could not update your packages."
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
        "$scripts_dir/notification.sh" notify "󱓽 Updates Available: $upd"
    fi

    sleep 1

    update_packages() {
        # Run the update command and capture the return code
        alacritty --title systemupdate -e sh -c "sudo dnf update -y && sudo dnf upgrade -y"
        upd=$?

        sleep 2

        if [ $upd -eq 0 ]; then
            "$scripts_dir"/notification.sh notify "  Packages updated successfully"
        elif [ $upd -gt 0 ]; then
            "$scripts_dir"/notification.sh notify "Some packages were skipped..."
        else
            "$scripts_dir"/notification.sh notify "Could not update your packages."
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
            "$scripts_dir/notification.sh" notify "󱓽 Updates Available: $upd"
        fi

        update_packages() {
            alacritty --title systemupdate -e sh -c "sudo zypper up"

            sleep 2
                
            if ((upd == 0)); then
                "$scripts_dir/notification.sh" notify "  Packages updated successfully"
            elif ((upd > 0)); then
                "$scripts_dir/notification.sh" notify "Some packages were skipped..."
            else
                "$scripts_dir/notification.sh" notify "Could not update your packages."
            fi
        }
    fi
fi

# Trigger upgrade
if [ "$1" == "up" ] ; then
    update_packages
fi

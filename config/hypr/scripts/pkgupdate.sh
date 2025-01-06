#!/bin/bash

display() {
    cat << "EOF"
╔═╗┬ ┬┌─┐┌┬┐┌─┐┌┬┐  ╦ ╦┌─┐┌┬┐┌─┐┌┬┐┌─┐
╚═╗└┬┘└─┐ │ ├┤ │││  ║ ║├─┘ ││├─┤ │ ├┤ 
╚═╝ ┴ └─┘ ┴ └─┘┴ ┴  ╚═╝┴  ─┴┘┴ ┴ ┴ └─┘
                                                     
EOF
}

display
printf "\n"

# asking for confirmation.
choice=$(gum confirm "System update..." \
        --affirmative "Update now!" \
        --negative "Skip updating!"
        )

if [ $? -eq 0 ]; then
    # updating the system
    if [ -n "$(command -v pacman)" ]; then
        aur=$(command -v yay || command -v paru)
        "$aur" -Syyu --noconfirm
    elif [ -n "$(command -v dnf)" ]; then
        sudo dnf update && sudo dnf upgrade -y
    elif [ -n "$(command -v zypper)" ]; then
        sudo zypper up -y
    fi

    sleep 1

    printf "\n\n<> Please press ENTER to close "
    read
else
    gum spin --spinner minidot --title "Skipping updating your system..." -- sleep 2
fi

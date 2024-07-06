#!/bin/bash

# Advanced Hyprland Installation Script by Js Bro ( https://github.com/me-js-bro )

# color defination
red="\e[1;31m"
green="\e[1;32m"
yellow="\e[1;33m"
blue="\e[1;34m"
megenta="\e[1;1;35m"
cyan="\e[1;36m"
orange="\x1b[38;5;214m"
end="\e[1;0m"

# initial texts
attention="[${orange} ATTENTION ${end}]"
action="[${green} ACTION ${end}]"
note="[${megenta} NOTE ${end}]"
done="[${cyan} DONE ${end}]"
ask="[${orange} QUESTION ${end}]"
error="[${red} ERROR ${end}]"

display_text() {
    cat << "EOF"
     _   _             _         _    _                 ____          _     __  _  _            
    | | | | _ __    __| |  __ _ | |_ (_) _ __    __ _  |  _ \   ___  | |_  / _|(_)| |  ___  ___ 
    | | | || '_ \  / _` | / _` || __|| || '_ \  / _` | | | | | / _ \ | __|| |_ | || | / _ \/ __|
    | |_| || |_) || (_| || (_| || |_ | || | | || (_| | | |_| || (_) || |_ |  _|| || ||  __/\__ \
     \___/ | .__/  \__,_| \__,_| \__||_||_| |_| \__, | |____/  \___/  \__||_|  |_||_| \___||___/
           |_|                                  |___/                                           
EOF
}

clear && display_text
printf " \n \n"

###------ Startup ------###

# finding the presend directory and log file
dir="$(dirname "$(realpath "$0")")"
# log directory
log_dir="$dir/Logs"
log="$log_dir"/update-dotfiles.log
mkdir -p "$log_dir"
touch "$log"

# Directories ----------------------------
hypr_dir="$HOME/.config/hypr"
scripts_dir="$hypr_dir/scripts"
fonts_dir="$HOME/.local/share/fonts"

printf "${action} - Updating to the Hyprland configuration.\n" && sleep 1
printf "${attention} - Would you like to remove the old dotfiles? If no, then we will be backing up those configs. [ y/n ]\n"
read -r -p "$(echo -e '\e[1;32mSelect: \e[0m')" bkup

mkdir -p ~/.config

dirs=(
    btop
    fastfetch
    hypr
    kitty
    nvim
    rofi
    swaync 
    waybar
    gtk-3.0
    gtk-4.0
    Kvantum
    ranger
    qt5ct
    qt6ct
)

# if some main directories exists, backing them up.
if [[ "$bkup" =~ ^[Yy]$ ]]; then

    for dir in "${dirs[@]}"; do

        dir_path="$HOME/.config/$dir"
        if [[ -d "$dir_path" ]]; then
            printf "${action} - Removing the old $dir_path. \n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
            rm -rf "$dir_path" 2>&1 | tee -a "$log"
            printf "${done} - Removed $dir.\n"
        fi
done

else

    for dir in "${dirs[@]}"; do
        dir_path=~/.config/$dir
        if [[ -d "$dir_path" ]]; then
            printf "${attention} - backing up old $dir_path\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
            mv "$dir_path" "$dir_path"-${USER} 2>&1 | tee -a "$log"
            printf "${done} - Backed up $dir.\n"
        fi
    done
fi

sleep 1 && clear

git clone --depth=1 https://github.com/me-js-bro/hyprconf.git "$HOME/.cache/hyprconf"

if [[ -d "$HOME/.cache/hyprconf" ]]; then
    cd "$HOME/.cache/hyprconf"
    chmod +x setup.sh
    ./setup.sh
fi


# Removint the cache file
if [[ -d "$HOME/.config/hypr/scripts" ]]; then
    printf "${done} - Dotfiles were update successfully. Removing the cache.\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")

    rm -rf "$HOME/.cache/hyprconf" &> /dev/null
    exit 0
fi

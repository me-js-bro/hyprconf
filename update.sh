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

if command -v gum &> /dev/null; then

display_text() {
    gum style \
        --border rounded \
        --align center \
        --width 60 \
        --margin "1" \
        --padding "1" \
'
  __  __        __     __        __ __                            ___
 / / / /__  ___/ /__ _/ /____   / // /_ _____  ___________  ___  / _/
/ /_/ / _ \/ _  / _ `/ __/ -_) / _  / // / _ \/ __/ __/ _ \/ _ \/ _/ 
\____/ .__/\_,_/\_,_/\__/\__/ /_//_/\_, / .__/_/  \__/\___/_//_/_/   
    /_/                            /___/_/                           
'
}

else
display_text() {
    cat << "EOF"
  __  __        __     __        __ __                            ___
 / / / /__  ___/ /__ _/ /____   / // /_ _____  ___________  ___  / _/
/ /_/ / _ \/ _  / _ `/ __/ -_) / _  / // / _ \/ __/ __/ _ \/ _ \/ _/ 
\____/ .__/\_,_/\_,_/\__/\__/ /_//_/\_, / .__/_/  \__/\___/_//_/_/   
    /_/                            /___/_/                             

EOF
}
fi

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

printf "${action}\n==> Updating to the Hyprland configuration.\n" && sleep 1
printf "${action}\n==> Backing up old dotfiles.\n"

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

for dir in "${dirs[@]}"; do
    dir_path=~/.config/$dir
    if [[ -d "$dir_path" ]]; then
        printf "${attention}\n! backing up old $dir_path\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
        mkdir -p "$HOME/.config/HyprBackup"-${USER}
        mv "$dir_path" "$HOME/.config/HyprBackup"-* 2>&1 | tee -a "$log"
        printf "${done}\n:: Backed up $dir.\n"
    fi
done

sleep 1 && clear

git clone --depth=1 https://github.com/me-js-bro/hyprconf.git "$HOME/.cache/hyprconf"

if [[ -d "$HOME/.cache/hyprconf" ]]; then
    cd "$HOME/.cache/hyprconf"
    chmod +x setup.sh
    ./setup.sh
fi


# Removint the cache file
if [[ -d "$HOME/.config/hypr/scripts" ]]; then
    printf "${done}\n:: Dotfiles were update successfully. Removing the cache.\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")

    rm -rf "$HOME/.cache/hyprconf" &> /dev/null
    exit 0
fi
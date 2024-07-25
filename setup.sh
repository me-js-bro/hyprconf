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
   ____                __  _                      _                 _   _                      _                    _ 
  / ___| ___   _ __   / _|(_)  __ _  _   _  _ __ (_) _ __    __ _  | | | | _   _  _ __   _ __ | |  __ _  _ __    __| |
 | |    / _ \ | '_ \ | |_ | | / _` || | | || '__|| || '_ \  / _` | | |_| || | | || '_ \ | '__|| | / _` || '_ \  / _` |
 | |___| (_) || | | ||  _|| || (_| || |_| || |   | || | | || (_| | |  _  || |_| || |_) || |   | || (_| || | | || (_| |
  \____|\___/ |_| |_||_|  |_| \__, | \__,_||_|   |_||_| |_| \__, | |_| |_| \__, || .__/ |_|   |_| \__,_||_| |_| \__,_|
                              |___/                         |___/          |___/ |_|                                  
EOF
}

clear && display_text
printf " \n \n"

###------ Startup ------###

# finding the presend directory and log file
dir="$(dirname "$(realpath "$0")")"
# log directory
log_dir="$dir/Logs"
log="$log_dir"/dotfiles.log
mkdir -p "$log_dir"
touch "$log"


# Directories ----------------------------
hypr_dir="$HOME/.config/hypr"
scripts_dir="$hypr_dir/scripts"
fonts_dir="$HOME/.local/share/fonts"

printf "${attention} - Now setting up the pre installed Hyprland configuration.\n" && sleep 1

mkdir -p ~/.config



# =========  checking the distro  ========= #

check_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            arch)
                printf "${action} - Starting the script for ${cyan}$ID${end} Linux\n\n"
                distro="arch"
                ;;
            fedora)
                printf "${action} - Starting the script for ${cyan}$ID${end}\n\n"
                distro="fedora"
                ;;
            opensuse*)
                printf "${action} - Starting the script for ${cyan}$ID${end}\n\n"
                distro="opensuse"
                ;;
            *)
                printf "${error} - Sorry, the script won't work in your distro...\n"
                exit 1
                ;;
        esac
    else
        printf "${error} - Sorry, the script won't work in $ID...\n"
        exit 1
    fi
}

dirs=(
    btop
    fastfetch
    hypr
    kitty
    nvim
    ranger
    rofi
    swaync 
    waybar
    gtk-3.0
    gtk-4.0
    Kvantum
    qt5ct
    qt6ct
)

# if some main directories exists, backing them up.
for confs in "${dirs[@]}"; do
    dir_path=~/.config/$confs
    if [[ -d "$dir_path" ]]; then
        printf "${attention} - Config for $confs located, backing up...\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
        mv "$dir_path" "$dir_path"-${USER} 2>&1 | tee -a "$log"
        printf "${done} - Backed up $dir.\n"
    fi
done

sleep 1

#_____ if OpenBangla Keyboard is installed, then setup to write bangla.
keyboard_path="/usr/share/openbangla-keyboard"

if [[ -d "$keyboard_path" ]]; then
    printf "${action} - Setting up OpenBangla-Keyboard to write bangla\n"

    # Add fcitx5 environment variables to /etc/environment if not already present
    if ! grep -q "GTK_IM_MODULE=fcitx" /etc/environment; then
        printf "\nGTK_IM_MODULE=fcitx\n" | sudo tee -a /etc/environment 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
    fi

    if ! grep -q "QT_IM_MODULE=fcitx" /etc/environment; then
        printf "QT_IM_MODULE=fcitx\n" | sudo tee -a /etc/environment 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
    fi

    if ! grep -q "XMODIFIERS=@im=fcitx" /etc/environment; then
        printf "XMODIFIERS=@im=fcitx\n" | sudo tee -a /etc/environment 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
    fi

fi

#_____ for virtual machine
# Check if the configuration is in a virtual box
if hostnamectl | grep -q 'Chassis: vm'; then
    printf "${action} - You are using this script in a Virtual Machine. Setting up things for you.\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
    # Comment out the line 'monitor=,preferred,auto,auto'
    sed -i '/monitor=,preferred,auto,auto/s/^/#/' config/hypr/configs/settings.conf

    sed -i '/env = WLR_NO_HARDWARE_CURSORS,1/s/^#//' config/hypr/configs/environment.conf
    sed -i '/env = WLR_RENDERER_ALLOW_SOFTWARE,1/s/^#//' config/hypr/configs/environment.conf
    sed -i '/monitor=Virtual-1, 1920x1080@60,auto,1/s/^#//' config/hypr/configs/settings.conf
fi


#_____ for nvidia gpu. I don't know if it's gonna work or not. Because I don't have any gpu.
# uncommenting WLR_NO_HARDWARE_CURSORS if nvidia is detected
if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
  echo "Nvidia GPU detected. Setting up proper env's" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log") || true
  sed -i '/env = WLR_NO_HARDWARE_CURSORS,1/s/^#//' config/hypr/configs/environment.conf
  sed -i '/env = LIBVA_DRIVER_NAME,nvidia/s/^#//' config/hypr/configs/environment.conf
  sed -i '/env = __GLX_VENDOR_LIBRARY_NAME,nvidia/s/^# //' config/hypr/configs/environment.conf
fi

sleep 1

# cloning the dotfiles repository into ~/.config/hypr
cp -r "$dir"/config/* "$HOME"/.config/
sleep 1

if [ -d $scripts_dir ]; then
    # make all the scripts executable...
    chmod +x "$scripts_dir"/* 2>&1 | tee -a "$log"
    chmod +x "$HOME/.config/ranger/scope.sh" 2>&1 | tee -a "$log"

    printf "${done} - All the necessary scripts have been executable.\n"
    sleep 1
else
    printf "${error} - Could not find necessary scripts\n"
fi

# Install Fonts
printf "${attention} - Installing some fonts.. \n"
if [[ ! -d "$fonts_dir" ]]; then
	mkdir -p "$fonts_dir"
fi

cp -r "$dir/extras/fonts" "$fonts_dir"
printf "${action} - Updating font cache...\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
sudo fc-cache -fv


wayland_session_dir=/usr/share/wayland-sessions
if [ -d "$wayland_session_dir" ]; then
    printf "${done} - $wayland_session_dir found\n"
else
    printf "${attention} - $wayland_session_dir NOT found, creating...\n"
    sudo mkdir $wayland_session_dir 2>&1 | tee -a "$log"
fi
    sudo cp "$dir/extras/hyprland.desktop" /usr/share/wayland-sessions/ 2>&1 | tee -a "$log"

clear && sleep 1


# Asking if the user wants to download more wallpapers
printf "${attention} - Would you like to add more ${green}Wallpapers${end}? ${blue}[ y/n ]${end}\n"
read -r -p "$(echo -e '\e[1;32mSelect: \e[0m')" wallpaper

printf " \n"

# wallpaper...
if [[ "$wallpaper" =~ ^[Y|y]$ ]]; then
    printf "${action} - Downloading some wallpapers...\n" && sleep 1

    # cloning the wallpapers in a temporary directory
    git clone --depth=1 https://github.com/me-js-bro/Wallpapers.git ~/.wallpaper-cache 2>&1 | tee -a "$log"

    # copying the wallpaper to the main directory
    if [[ -d "$HOME/.wallpaper-cache" ]]; then
        cp "$HOME/.wallpaper-cache/dark"/* ~/.config/hypr/Dynamic-Wallpapers/dark/
        cp "$HOME/.wallpaper-cache/light"/* ~/.config/hypr/Dynamic-Wallpapers/light/
        cp "$HOME/.wallpaper-cache/all"/* ~/.config/hypr/Wallpaper/
        sudo rm -rf "$HOME/.wallpaper-cache"
        printf "${done} - Wallpapers were downloaded successfully..\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log") & sleep 0.5
    else
        printf "${error} - Sorry, could not download wallpapers\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log") && sleep 0.5
    fi
fi

# setting default themes, icon and cursor
gsettings set org.gnome.desktop.interface gtk-theme "theme"
gsettings set org.gnome.desktop.interface icon-theme "TokyoNight-SE"
gsettings set org.gnome.desktop.interface cursor-theme "Nordzy-cursors"



# =========  wallpaper section  ========= #

check_distro &> /dev/null

if [[ -d "$HOME/.config/hypr/Wallpaper" ]]; then
  mode_file="$HOME/.mode"
  engine="$HOME/.config/hypr/.cache/.engine"

  touch "$mode_file" &> /dev/null
  touch "$engine" &> /dev/null
  
  echo "dark" > "$mode_file"
  echo "hyprpaper" > "$engine"

  wallpaper="$HOME/.config/hypr/Wallpaper/$distro.png"

# setting the default wallpaper
  ln -sf "$wallpaper" "$HOME/.config/hypr/.cache/current_wallpaper.png"
   echo "wallpaper = ,/home/js-bro/.config/hypr/.cache/current_wallpaper.png" > "$HOME/.config/hypr/hyprpaper"
  "$HOME/.config/hypr/scripts/pywal.sh"
fi

# setting up the waybar
ln -sf "$HOME/.config/waybar/configs/fancy-top" "$HOME/.config/waybar/config"
ln -sf "$HOME/.config/waybar/style/fancy-top.css" "$HOME/.config/waybar/style.css"

printf "${done} - Script execution was successful! Now you can reboot and enjoy your customization \n"

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
   __ __                            ___
  / // /_ _____  ___________  ___  / _/
 / _  / // / _ \/ __/ __/ _ \/ _ \/ _/ 
/_//_/\_, / .__/_/  \__/\___/_//_/_/   
     /___/_/                                
'
}

else
display_text() {
    cat << "EOF"
   __ __                            ___
  / // /_ _____  ___________  ___  / _/
 / _  / // / _ \/ __/ __/ _ \/ _ \/ _/ 
/_//_/\_, / .__/_/  \__/\___/_//_/_/   
     /___/_/                              

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
log="$log_dir"/dotfiles.log
mkdir -p "$log_dir"
touch "$log"


# Directories ----------------------------
hypr_dir="$HOME/.config/hypr"
scripts_dir="$hypr_dir/scripts"
fonts_dir="$HOME/.local/share/fonts"

printf "${attention}\n! Now setting up the pre installed Hyprland configuration.\n" && sleep 1

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
    dunst
    fastfetch
    hypr
    kitty
    nvim
    ranger
    rofi
    waybar
    gtk-3.0
    gtk-4.0
    Kvantum
    qt5ct
    qt6ct
)

# if some main directories exists, backing them up.
if [[ -d "$HOME/.config/HyprBackup-${USER}" ]]; then
    printf "${attention}\n! a HyprBackup directory was there. Archiving it.\n"
    cd "$HOME/.config"
    mkdir -p "HyprArchive-${USER}"
    zip -r -1 "HyprBackup-${USER}.zip" "HyprBackup-${USER}" &> /dev/null
    mv "HyprBackup-${USER}.zip" "HyprArchive-${USER}/"
    rm -rf "HyprBackup-${USER}"
    printf "${done}\n:: HyprBackup-${USER} was zipped and backed to HyprArchive-${USER} directory.\n"
fi

for confs in "${dirs[@]}"; do
    mkdir -p "$HOME/.config/HyprBackup-${USER}"
    dir_path="$HOME/.config/$confs"
    if [[ -d "$dir_path" ]]; then
        mv "$dir_path" "$HOME/.config/HyprBackup-${USER}/" 2>&1 | tee -a "$log"
        printf "${done}\n:: Everything has been backuped in $HOME/.config/HyprBackup-${USER}.\n"
    fi
done

sleep 1

#_____ if OpenBangla Keyboard is installed
keyboard_path="/usr/share/openbangla-keyboard"

if [[ -d "$keyboard_path" ]]; then
    printf "${action}\n==> Setting up OpenBangla-Keyboard.\n"

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
    printf "${attention}\n! You are using this script in a Virtual Machine.\n${action}\n=> Setting up things for you.\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
    sed -i '/env = WLR_NO_HARDWARE_CURSORS,1/s/^#//' "$dir/config/hypr/configs/environment.conf"
    sed -i '/env = WLR_RENDERER_ALLOW_SOFTWARE,1/s/^#//' "$dir/config/hypr/configs/environment.conf"
    echo -e '#Monitor\nmonitor=Virtual-1, 1920x1080@60,auto,1' > "$dir/config/hypr/configs/monitor.conf"

else
    #_____ setting up the monitor
    printf "${action}\n==> Setting the default monitor setup.\n"
    echo -e "#Monitor\nmonitor=,preferred,auto,auto" > "$dir/config/hypr/configs/monitor.conf"
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
    printf "${done}\n:: All the necessary scripts have been executable.\n"
    sleep 1
else
    printf "${error}\n! Could not find necessary scripts\n"
fi

# Install Fonts
printf "${attention}\n! Installing some fonts.. \n"
if [[ ! -d "$fonts_dir" ]]; then
	mkdir -p "$fonts_dir"
fi

cp -r "$dir/extras/fonts" "$fonts_dir"
printf "${action}\n==> Updating font cache...\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
sudo fc-cache -fv &> /dev/null


wayland_session_dir=/usr/share/wayland-sessions
if [ -d "$wayland_session_dir" ]; then
    printf "${done}\n:: $wayland_session_dir found\n"
else
    printf "${attention}\n! $wayland_session_dir NOT found, creating.\n"
    sudo mkdir $wayland_session_dir 2>&1 | tee -a "$log"
fi
    sudo cp "$dir/extras/hyprland.desktop" /usr/share/wayland-sessions/ 2>&1 | tee -a "$log"

clear && sleep 1


# Asking if the user wants to download more wallpapers
if [[ -n "$(command -v gum)" ]]; then
    printf "${ask}\n?? Would you like to add more wallpapers?\n"
    gum confirm "Please confirm." \
        --affirmative "Need more wallpapers" \
        --negative "No, skip"

    if [ $? -eq 0 ]; then
       wallpaper="y" 
    else
        wallpaper="n"
    fi
else
    printf "${ask}\n?? Would you like to add more ${green}Wallpapers${end}? ${blue}[ y/n ]${end}\n"
    read -r -p "$(echo -e '\e[1;32mSelect: \e[0m')" wallpaper
fi

printf " \n"

# wallpaper...
if [[ "$wallpaper" =~ ^[Y|y]$ ]]; then
    printf "${action}\n==> Downloading some wallpapers.\n" && sleep 1
    
    # cloning the wallpapers in a temporary directory
    git clone --depth=1 https://github.com/me-js-bro/Wallpapers.git ~/.cache/wallpaper-cache 2>&1 | tee -a "$log" &> /dev/null

    # copying the wallpaper to the main directory
    if [[ -d "$HOME/.cache/wallpaper-cache" ]]; then
        cp "$HOME/.cache/wallpaper-cache/dark"/* ~/.config/hypr/Dynamic-Wallpapers/dark/ &> /dev/null
        cp "$HOME/.cache/wallpaper-cache/light"/* ~/.config/hypr/Dynamic-Wallpapers/light/ &> /dev/null
        cp "$HOME/.cache/wallpaper-cache/all"/* ~/.config/hypr/Wallpaper/ &> /dev/null
        rm -rf "$HOME/.cache/wallpaper-cache" &> /dev/null
        printf "${done}\n:: Wallpapers were downloaded successfully..\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log") & sleep 0.5
    else
        printf "\n${error}\n! Sorry, could not download more wallpapers. Going forward with the limited wallpapers.\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log") && sleep 0.5
    fi
fi

# =========  wallpaper section  ========= #

check_distro &> /dev/null

if [[ -d "$HOME/.config/hypr/Wallpaper" ]]; then
  mode_file="$HOME/.config/hypr/.cache/.mode"
  engine="$HOME/.config/hypr/.cache/.engine"
  wallCache="$HOME/.config/hypr/.cache/.wallpaper"

  touch "$mode_file" &> /dev/null
  touch "$engine" &> /dev/null
  touch "$wallCache" &> /dev/null
  
  echo "dark" > "$mode_file"
  echo "hyprpaper" > "$engine"
  echo "${distro}" > "$wallCache"

  wallpaper="$HOME/.config/hypr/Wallpaper/$distro.png"

# setting the default wallpaper
  ln -sf "$wallpaper" "$HOME/.config/hypr/.cache/current_wallpaper.png"
   echo "wallpaper = ,$HOME/.config/hypr/.cache/current_wallpaper.png" > "$HOME/.config/hypr/hyprpaper.conf"
  "$HOME/.config/hypr/scripts/pywal.sh" &> /dev/null
fi

# setting up the waybar
ln -sf "$HOME/.config/waybar/configs/catppuccin-top" "$HOME/.config/waybar/config"
ln -sf "$HOME/.config/waybar/style/catppuccin-top.css" "$HOME/.config/waybar/style.css"

printf "${done}\n:: Script execution was successful! Now you can reboot and enjoy your customization.\n"

# === ___ Script Ends Here ___ === #

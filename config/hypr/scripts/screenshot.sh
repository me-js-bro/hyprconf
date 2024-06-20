#!/bin/bash

if [ -z "$XDG_PICTURES_DIR" ] ; then
    XDG_PICTURES_DIR="$HOME/Pictures"
fi

swpy_dir="$HOME/.config/swappy"
save_dir="${2:-$XDG_PICTURES_DIR/Screenshots}"
save_file=$(date +'%y%m%d_%I%M%p_screenshot.png')
temp_screenshot="/tmp/screenshot.png"

mkdir -p $save_dir
mkdir -p $swpy_dir
echo -e "[Default]\nsave_dir=$save_dir\nsave_filename_format=$save_file" > $swpy_dir/config

function print_error
{
cat << "EOF"
    ./screenshot.sh <action>
    ...valid actions are...
        p : print all screens
        s : snip current screen
EOF
}

option2="Selected area"
option3="Fullscreen (delay 1 sec)"

options="$option2\n$option3"

choice=$(echo -e "$options" | rofi -dmenu -replace -config ~/.config/rofi/themes/config-screenshots.rasi -i -no-show-icons -l 2 -width 30 -p)

case $choice in
    $option2)  # print all outputs
        sleep 0.5
        grimblast --freeze copysave area $temp_screenshot && swappy -f $temp_screenshot 
        ;;
    $option3)  # drag to manually snip an area / click on a window to print it
        sleep 0.5
        grimblast copysave screen $temp_screenshot && swappy -f $temp_screenshot
        ;;
    *)  # invalid option
        print_error ;;
esac

rm "$temp_screenshot"

if [ -f "$save_dir/$save_file" ] ; then
    notify-send "saved in $save_dir" -i "$save_dir/$save_file" -r 91190 -t 2200
fi
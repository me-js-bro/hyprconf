#!/bin/bash

#______ If you want to add your prompt here, just add into the "case" condition, and also into the "display_menu function." ______#

# Function to display the menu
display_menu() {
    echo "Style-1"
    echo "Style-2"
    echo "Style-3"
    echo "Style-4"
    echo "Style-5"
    echo "Style-6"
    echo "Style-7"
    echo "Style-8"
}

rofi_command="rofi -i -dmenu -config ~/.config/rofi/themes/config-shell.rasi"


main() {
    style=$(display_menu | ${rofi_command})

# case to choose the PS1 variable
# everything you see "\e[..." are just colors...
case $style in
    Style-1)
        PS1='\e[90m${elapsed_time_display}\e[0m\n┌( \u )─[$(if [[ "$PWD" = "$HOME" ]]; then echo " \e[1;36m󰋜\e[1;0m"; elif [[ "$PWD" = "/" ]]; then echo " \e[1;32m$(check_distro)\e[1;0m"; else echo " \w"; fi) $(git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo $(git_info) || echo "")]\n└─|> '
        ;;
    Style-2)
        PS1='\e[90m${elapsed_time_display}\e[0m\n$(if [[ "$PWD" = "$HOME" ]]; then echo "\e[1;36m\e[1;0m"; elif [[ "$PWD" = "/" ]]; then echo " \e[1;32m$(check_distro)\e[1;0m"; else echo "\W"; fi) $(git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo $(git_info) || echo "")\e[1;32m❯\e[1;0m '
        ;;
    Style-3)
        PS1='\e[90m${elapsed_time_display}\e[0m\n$(git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo $(git_info) || echo "") \n $(if [[ "$PWD" = "$HOME" ]]; then echo "\e[1;36m󰜥\e[1;0m"; elif [[ "$PWD" = "/" ]]; then echo "\e[1;36m\e[1;0m"; else echo "\W"; fi) \e[1;32m\e[1;0m ' 
        ;;
    Style-4)
        PS1='\e[90m${elapsed_time_display}\e[0m\n\e[1;36m╭─\e[1;0m $(if [[ "$PWD" = "$HOME" ]]; then echo "\e[1;36m  $(check_distro)\e"; elif [[ "$PWD" = "/" ]]; then echo "\e[1;36m\e[1;0m"; else echo "\e[1;33m\w"; fi) $(git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo $(git_info) || echo "") \n\e[1;36m╰──\e[1;32m❯\e[1;0m '
        ;;
    Style-5)
        PS1='\e[90m${elapsed_time_display}\e[0m\n\e[1;36m╭─ \e[1;37m\u\e[1;34m@\e[1;37m\h\e[1;0m in $(if [[ "$PWD" = "$HOME" ]]; then echo "\e[1;36m󰜥"; elif [[ "$PWD" = "/" ]]; then echo "\e[1;36m\e[1;0m"; else echo "\e[1;33m\W"; fi) $(git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo $(git_info) || echo "")\n\e[1;36m╰──\e[1;32m󰘧\e[1;0m '
        ;;
    Style-6)
        PS1='\e[90m${elapsed_time_display}\e[0m\n$(if [[ "$PWD" = "$HOME" ]]; then echo " " ; elif [[ "$PWD" = "/" ]]; then echo " \e[1;32mroot\e[1;0m"; else echo " \w"; fi) $(git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo $(git_info) || echo "")$(current_time)\n \e[1;32m❯\e[1;0m '
        ;;
    Style-7)
        PS1='\n\e[90m${elapsed_time_display}\e[0m\n\e[1;36m \u\e[1;34m in \e[1;33m \h\e[1;0m // $(if [[ "$PWD" = "$HOME" ]]; then echo "\e[1;36m󰜥"; elif [[ "$PWD" = "/" ]]; then echo "\e[1;36m\e[1;0m"; else echo "\e[1;33m\w"; fi)$(git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo $(git_info) || echo "")\e[1;36m\e[1;32m\e[1;0m :$ '
        ;;
    Style-8)
        PS1='\e[90m${elapsed_time_display}\e[0m\n╭( \u )─[$(if [[ "$PWD" = "$HOME" ]]; then echo " \e[1;36m \e[1;0m"; elif [[ "$PWD" = "/" ]]; then echo " \e[1;32m \e[1;0m"; else echo "\e[1;33m \W\e[1;0m"; fi) ]$(git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo ──{ $(git_info) }─ || echo "")─( $(current_time) )\n╰─\e[1;32m❯\e[1;0m '
        ;;
esac

# Escape backslashes, forward slashes, and newlines in PS1 for sed
escaped_PS1=$(printf '%s\n' "$PS1" | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e ':a;N;$!ba;s/\n/\\n/g')

# bash file
bashrc=~/.bash/.bashrc

# Update the PS1 line in the specified file
sed -i "/^PS1=/c\\PS1='$escaped_PS1'" "$bashrc"

source ~/.bash/.bashrc

printf "Now relaunch your terminal and you're good to go...\n"

}

main

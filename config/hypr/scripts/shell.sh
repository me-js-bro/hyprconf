#!/bin/bash

# Get the username of the current user
current_user=$(whoami)

# Get the user's shell
user_shell=$(getent passwd "$current_user" | cut -d: -f7)

# Extract just the name of the shell
user_shell=$(basename "$user_shell")

# Check if the user's shell is Bash
if [ "$user_shell" = "bash" ]; then
    "$HOME/.config/hypr/scripts/bash_themes.sh"
# Check if the user's shell is Zsh
elif [ "$user_shell" = "zsh" ]; then
    "$HOME/.config/hypr/scripts/zsh_themes.sh"
else
    echo "User's shell is a different shell: $user_shell"
fi

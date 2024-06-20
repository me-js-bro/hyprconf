#!/bin/bash

# Path to the sound files
SOUND_FILE_UPDATE="$HOME/.config/hypr/sounds/update.wav"
SOUND_FILE_SYSTEM="$HOME/.config/hypr/sounds/system-startup.wav"

# Function to send notification and play sound
notify_with_sound() {
    notify-send "$1"
    paplay "$SOUND_FILE_UPDATE"
}

startup_with_sound() {
    notify-send "$1"
    paplay "$SOUND_FILE_SYSTEM"
}

case $1 in
  sys)
      if [ -n "$2" ]; then
          startup_with_sound "$2"
      else
          startup_with_sound 
      fi
      ;;
  notify)
      if [ -n "$2" ]; then
          notify_with_sound "$2"
      else
          echo "Please provide a message for the notification."
      fi
      ;;
  *)
      echo "Usage: $0 {sys|notify} [message]"
      ;;
esac

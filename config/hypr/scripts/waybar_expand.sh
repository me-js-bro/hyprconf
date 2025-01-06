#!/bin/bash

# Initial state
expanded=0

# Check for input argument
if [[ $1 == "toggle" ]]; then
  if [[ -f /tmp/waybar_expanded ]]; then
    expanded=$(< /tmp/waybar_expanded)
  fi
  expanded=$((1 - expanded)) # Toggle state
  echo $expanded > /tmp/waybar_expanded
fi

# Output based on state
if [[ $expanded -eq 1 ]]; then
  echo '{"text": "Options ▼", "tooltip": "Click to collapse", "class": "expanded"}'
else
  echo '{"text": "Menu ▲", "tooltip": "Click to expand", "class": "collapsed"}'
fi

#!/bin/bash

if [ $(hyprctl -j getoption misc:cursor_zoom_factor | jq '.float' | sed 's/\..*$//') == 1 ]; then
  $(hyprctl keyword misc:cursor_zoom_factor 2) &> /dev/null
else
  $(hyprctl keyword misc:cursor_zoom_factor 1) &> /dev/null
fi
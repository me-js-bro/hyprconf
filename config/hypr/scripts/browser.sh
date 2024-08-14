#!/bin/bash

# finding the browse to open with --enable-wayland-ime 

# browser location
if [[ -n $(command -v brave) ]]; then
    brave --enable-wayland-ime

elif [[ -n $(command -v brave-browser) ]]; then
    brave-browser --enable-wayland-ime

elif [[ -n $(command -v chromium) ]]; then
    chromium --enable-wayland-ime

elif [[ -n $(command -v chromium-browser) ]]; then
    chromium-browser --enable-wayland-ime
    
fi
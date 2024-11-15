#!/bin/bash

# finding the browse to open with --enable-wayland-ime 

# browser location
if command -v brave &> /dev/null; then
    brave --enable-wayland-ime

elif command -v brave-browser &> /dev/null; then
    brave-browser --enable-wayland-ime

elif command -v chromium &> /dev/null; then
    chromium --enable-wayland-ime

elif command -v chromium-browser &> /dev/null; then
    chromium-browser --enable-wayland-ime  
fi
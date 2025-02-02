#!/usr/bin/env sh

# Set environment variables
export cacheDir="$HOME/.config/hypr/.cache"
export thmbDir="${cacheDir}/thumbs"
currentWall_name="$(cat "${cacheDir}/.wallpaper")"

# Input file
input_file="${cacheDir}/current_wallpaper.png"

mkdir -p "${thmbDir}"
chmod u+w "${thmbDir}"

# Check if the input file exists
if [ ! -f "${input_file}" ]; then
    exit 1
fi

# Define the fn_wallcache function
fn_wallcache() {
    local wall_name="${1}"
    local x_wall="${2}"

    # Generate square thumbnail
    [ ! -e "${thmbDir}/${wall_name}.sqre" ] && \
        magick "${x_wall}"[0] -strip -thumbnail 500x500^ -gravity center -extent 500x500 \
        "${thmbDir}/${wall_name}.sqre"

    # Generate blurred image
    [ ! -e "${thmbDir}/${wall_name}.blur" ] && \
        magick "${x_wall}"[0] -strip -scale 70% -blur 0x10 -resize 100% \
        "${thmbDir}/${wall_name}.blur"

    # Generate quad image
    [ ! -e "${thmbDir}/${wall_name}.quad" ] && \
        magick "${thmbDir}/${wall_name}.sqre" \
        \( -size 500x500 xc:white -fill "rgba(0,0,0,0.7)" \
           -draw "polygon 400,500 500,500 500,0 450,0" \
           -fill black \
           -draw "polygon 500,500 500,0 450,500" \) \
        -alpha Off -compose CopyOpacity -composite \
        "${thmbDir}/${wall_name}.png" && \
        mv "${thmbDir}/${wall_name}.png" "${thmbDir}/${wall_name}.quad"

    [[ -f "${cacheDir}/${wall_name}.blur" ]] && rm -rf  "${cacheDir}/${wall_name}.blur"
    cp -r "${thmbDir}/${wall_name}.blur" "${cacheDir}/wall.blur"

    [[ -f "${cacheDir}/${wall_name}.quad" ]] && rm -rf  "${cacheDir}/${wall_name}.quad"
    cp -r "${thmbDir}/${wall_name}.quad" "${cacheDir}/wall.quad"
}

# Process the current wallpaper
fn_wallcache "${currentWall_name}" "${input_file}"

if [ ! -f "${thmbDir}/${currentWall_name}.quad" ]; then
    exit 1
fi

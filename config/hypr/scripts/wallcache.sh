#!/usr/bin/env sh

# Set environment variables
export cacheDir="$HOME/.config/hypr/.cache"
export thmbDir="${cacheDir}/thumbs"

# Input file
input_file="${cacheDir}/current_wallpaper.png"

mkdir -p "${thmbDir}"
chmod u+w "${thmbDir}"

# Check if the input file exists
if [ ! -f "${input_file}" ]; then
    echo "Error: Input file '${input_file}' not found!"
    exit 1
fi

# Hash calculation for caching purposes
x_hash="$(sha256sum "${input_file}" | cut -d' ' -f1)"

# Define the fn_wallcache function
fn_wallcache() {
    local x_hash="${1}"
    local x_wall="${2}"

    # Generate square thumbnail
    [ ! -e "${thmbDir}/${x_hash}.sqre" ] && \
        magick "${x_wall}"[0] -strip -thumbnail 500x500^ -gravity center -extent 500x500 \
        "${thmbDir}/${x_hash}.sqre"

    # Generate blurred image
    [ ! -e "${thmbDir}/${x_hash}.blur" ] && \
        magick "${x_wall}"[0] -strip -scale 10% -blur 0x3 -resize 100% \
        "${thmbDir}/${x_hash}.blur"

    # Generate quad image
    [ ! -e "${thmbDir}/${x_hash}.quad" ] && \
        magick "${thmbDir}/${x_hash}.sqre" \
        \( -size 500x500 xc:white -fill "rgba(0,0,0,0.7)" \
           -draw "polygon 400,500 500,500 500,0 450,0" \
           -fill black \
           -draw "polygon 500,500 500,0 450,500" \) \
        -alpha Off -compose CopyOpacity -composite \
        "${thmbDir}/${x_hash}.png" && \
        mv "${thmbDir}/${x_hash}.png" "${thmbDir}/${x_hash}.quad"

    ln -sf "${thmbDir}/${x_hash}.blur" "${cacheDir}/wall.blur"
    ln -sf "${thmbDir}/${x_hash}.quad" "${cacheDir}/wall.quad"

}

# Process the current wallpaper
fn_wallcache "${x_hash}" "${input_file}"

# Notify success
if [ -f "${thmbDir}/${x_hash}.quad" ]; then
    echo "Quad image created successfully: ${thmbDir}/${x_hash}.quad"
else
    echo "Error: Quad image creation failed!"
    exit 1
fi

#!/bin/bash

svg2png() {
    input_file="$1"
    output_file="$2"
    width="$3"
    height="$4"

    inkscape -w "$width" -h "$height" -o "$output_file" "$input_file"
}

sipsresize() {
    input_file="$1"
    output_file="$2"
    width="$3"
    height="$4"

    sips -z "$width" "$height" "$input_file" --out "$output_file"
}

if command -v "inkscape" && command -v "icotool"; then
    # Windows ICO
    d=$(mktemp -d)

    svg2png org.sogik.NMCLauncher.svg "$d/nmclauncher_16.png" 16 16
    svg2png org.sogik.NMCLauncher.svg "$d/nmclauncher_24.png" 24 24
    svg2png org.sogik.NMCLauncher.svg "$d/nmclauncher_32.png" 32 32
    svg2png org.sogik.NMCLauncher.svg "$d/nmclauncher_48.png" 48 48
    svg2png org.sogik.NMCLauncher.svg "$d/nmclauncher_64.png" 64 64
    svg2png org.sogik.NMCLauncher.svg "$d/nmclauncher_128.png" 128 128
    svg2png org.sogik.NMCLauncher.svg "$d/nmclauncher_256.png" 256 256

    rm nmclauncher.ico && icotool -o nmclauncher.ico -c \
        "$d/nmclauncher_256.png"  \
        "$d/nmclauncher_128.png"  \
        "$d/nmclauncher_64.png"   \
        "$d/nmclauncher_48.png"   \
        "$d/nmclauncher_32.png"   \
        "$d/nmclauncher_24.png"   \
        "$d/nmclauncher_16.png"
else
    echo "ERROR: Windows icons were NOT generated!" >&2
    echo "ERROR: requires inkscape and icotool in PATH"
fi

if command -v "inkscape" && command -v "sips" && command -v "iconutil"; then
    # macOS ICNS
    d=$(mktemp -d)

    d="$d/nmclauncher.iconset"

    mkdir -p "$d"

    svg2png org.sogik.NMCLauncher.bigsur.svg "$d/icon_512x512@2x.png" 1024 1024
    sipsresize "$d/icon_512x512@2.png" "$d/icon_16x16.png" 16 16
    sipsresize "$d/icon_512x512@2.png" "$d/icon_16x16@2.png" 32 32
    sipsresize "$d/icon_512x512@2.png" "$d/icon_32x32.png" 32 32
    sipsresize "$d/icon_512x512@2.png" "$d/icon_32x32@2.png" 64 64
    sipsresize "$d/icon_512x512@2.png" "$d/icon_128x128.png" 128 128
    sipsresize "$d/icon_512x512@2.png" "$d/icon_128x128@2.png" 256 256
    sipsresize "$d/icon_512x512@2.png" "$d/icon_256x256.png" 256 256
    sipsresize "$d/icon_512x512@2.png" "$d/icon_256x256@2.png" 512 512
    iconutil -c icns "$d"
else
    echo "ERROR: macOS icons were NOT generated!" >&2
    echo "ERROR: requires inkscape, sips and iconutil in PATH"
fi

# replace icon in themes
cp -v org.sogik.NMCLauncher.svg "../launcher/resources/multimc/scalable/launcher.svg"

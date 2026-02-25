#!/usr/bin/env bash

# =================================================================================================
# Filename:  gen_images.sh
# About:     Script to convert *.drawio to *.svg and .pdf
# Platform:  Tested on macOS
# Usage:     source gen_images.sh
# =================================================================================================

DRAWIO=/Applications/draw.io.app/Contents/MacOS/draw.io
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SRC="$SCRIPT_DIR"
DEST="$SCRIPT_DIR/../_static/images"

echo "diagram source directory: $SRC"

# Ensure draw.io is installed
if [ ! -f "$DRAWIO" ]; then
  echo "Error: draw.io not found at $DRAWIO"
  exit 1
fi

# Ensure $DEST exist
mkdir -p "$DEST"

# Using nullglob to avoid error when no files
shopt -s nullglob

for file in *.drawio; do
  filename=$(basename "$file" .drawio)
  echo "$file"

  echo "-----------------------------------------------------"
  echo "Processing $filename..."
  
  # Export *.drawio to *.svg for html
  /Applications/draw.io.app/Contents/MacOS/draw.io -x -f svg --crop -o "${DEST}/${filename}.svg" $file

  # Export *.drawio to *.pdf for latexpdf
  /Applications/draw.io.app/Contents/MacOS/draw.io -x -f pdf --crop -o "${DEST}/${filename}.pdf" $file
done

echo "======== Done! ========"

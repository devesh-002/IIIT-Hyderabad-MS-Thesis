#!/bin/bash

# Ensure ImageMagick is installed
if ! command -v convert &> /dev/null
then
    echo "ImageMagick (convert) could not be found. Install it using: sudo apt install imagemagick"
    exit
fi

# Check if the directory argument is passed
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Set the base directory
BASE_DIR="$1"

# Find and convert all .jpeg files to .pdf
find "$BASE_DIR" -type f -iname "*.jpeg" | while read -r file; do
    # Get the file path without extension
    base_name="${file%.*}"
    
    # Convert to pdf format
    convert "$file" "$base_name.pdf"

    if [ $? -eq 0 ]; then
        echo "Converted: $file -> $base_name.pdf"
    else
        echo "Failed to convert: $file"
    fi
done

echo "Conversion process completed."


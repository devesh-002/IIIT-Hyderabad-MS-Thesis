#!/bin/bash

# Downscale all .pdf files under 'figures/' recursively to 400 DPI

TARGET_DIR="figures"
TARGET_DPI=200

# Check for Ghostscript
if ! command -v gs &> /dev/null; then
    echo "❌ Ghostscript ('gs') is not installed."
    exit 1
fi

echo ">> Searching for PDF files recursively under '$TARGET_DIR'..."

# Find all .pdf files (case-insensitive), recursively
mapfile -t PDF_FILES < <(find "$TARGET_DIR" -type f \( -iname "*.pdf" \))

if [ ${#PDF_FILES[@]} -eq 0 ]; then
    echo "⚠️ No PDF files found in '$TARGET_DIR'."
    exit 0
fi

# Process each file
for file in "${PDF_FILES[@]}"; do
    echo "   >> Processing: $file"
    tmpfile="${file%.pdf}_tmp.pdf"

    gs -sDEVICE=pdfwrite \
       -dCompatibilityLevel=1.4 \
       -r$TARGET_DPI \
       -dNOPAUSE -dQUIET -dBATCH \
       -sOutputFile="$tmpfile" "$file"

    mv "$tmpfile" "$file"
done

echo "✅ All PDF figures downscaled to ${TARGET_DPI} DPI (recursively)."


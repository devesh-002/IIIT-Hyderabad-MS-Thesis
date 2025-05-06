#!/bin/bash

# Minimal compression for high-quality LaTeX PDFs
# Usage: ./compress_latex_pdf_minimal.sh yourfile.pdf

INPUT_PDF="$1"
OUTPUT_PDF="${INPUT_PDF%.pdf}_compressed.pdf"

if [ -z "$INPUT_PDF" ]; then
  echo "Usage: $0 <filename.pdf>"
  exit 1
fi

if ! command -v gs &> /dev/null; then
    echo "❌ Ghostscript ('gs') is not installed."
    exit 1
fi

echo ">> Minimally compressing $INPUT_PDF..."

gs -sDEVICE=pdfwrite \
   -dCompatibilityLevel=1.4 \
   -dPDFSETTINGS=/prepress \
   -dNOPAUSE -dQUIET -dBATCH \
   -dDownsampleColorImages=true \
   -dColorImageResolution=300 \
   -dDownsampleGrayImages=true \
   -dGrayImageResolution=300 \
   -dDownsampleMonoImages=true \
   -dMonoImageResolution=300 \
   -sOutputFile="$OUTPUT_PDF" "$INPUT_PDF"

echo "✅ Compressed (minimal loss) PDF saved as: $OUTPUT_PDF"


#!/bin/bash

# Create backup directory
mkdir -p assets/images/original

# Backup original images
cp assets/images/*.jpg assets/images/original/

# Resize and optimize images
for img in assets/images/*.jpg; do
    if [ "$(basename "$img")" != "original" ]; then
        echo "Processing $img..."
        convert "$img" -resize 1600x1600\> -strip -quality 85 "$img"
    fi
done

echo "Image processing complete!"
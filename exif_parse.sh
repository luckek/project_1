#!/bin/bash

#####
# this script requires ImageMagick and bc programs
#####

# Get the directory to look for images from terminal
directory="$1"
# get all images
directory="$directory"
if [ ! -f "$directory" ]; then
echo "File doesn't exist: Usage /path/to/your/pic.jpg"
exit 0
fi

if [ $(echo "$directory" | grep -ic 'JPG') == 0 ]; then
echo "File must be jpg image: Usage /path/to/your/pic.jpg"
exit 0
fi

# define some regex patterns
regex='exif:FocalLength: ([0-9]+)/([0-9]+)'
width_reg='exif:ExifImageWidth: ([0-9]+)'
# Loop over all files in directory
for f in "$directory"; do 

# gets all exif output of jpgs
exifoutput=$(identify -verbose "$f" | grep exif:);
# get focal length
eo=$(echo "$exifoutput" | grep exif:FocalLength:);
if [[ $eo =~ $regex ]]; then
# echo "$f"
mmLength=$(echo "scale=3 ; ${BASH_REMATCH[1]} / ${BASH_REMATCH[2]}" | bc)
# echo "$mmLength"
fi
# get image width
ew=$(echo "$exifoutput" | grep exif:ExifImageWidth:);
if [[ $ew =~ $width_reg ]]; then
width=$(echo "${BASH_REMATCH[1]}")
# echo "$width"
pix=$(echo "scale=5 ; $mmLength / 36" | bc)
# echo "$pix"
pixWidth=$(echo "scale=5 ; $pix * $width" | bc)
echo "$pixWidth"
fi

done


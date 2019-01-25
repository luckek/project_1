#!/bin/bash

#####
# this script requires ImageMagick and bc programs
#####

# Get the directory to look for images from terminal
directory="$1"
# get all images
directory="$directory"'/*.jpg'

# define some regex patterns
regex='exif:FocalLength: ([0-9]+)/([0-9]+)'
width_reg='exif:ExifImageWidth: ([0-9]+)'

# Loop over all files in directory
for f in "$directory"; do 

# gets all exif output of jpgs
exifoutput=$(identify -verbose "$f" | grep exif:);
# get focal length
eo=$(echo "$exifoutput" | grep exif:FocalLength:);
[[ $eo =~ $regex ]]
echo "$f"
mmLength=$(echo "scale=3 ; ${BASH_REMATCH[1]} / ${BASH_REMATCH[2]}" | bc)
echo "$mmLength"

# get image width
ew=$(echo "$exifoutput" | grep exif:ExifImageWidth:);
[[ $ew =~ $width_reg ]]
width=$(echo "${BASH_REMATCH[1]}")
echo "$width"
pix=$(echo "scale=5 ; $mmLength / 36" | bc)
echo "$pix"
pixWidth=$(echo "scale=5 ; $pix * $width" | bc)
echo "$pixWidth"

done


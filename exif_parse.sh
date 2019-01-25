#!/bin/bash

directory=$1
directory=$directory'/*.jpg'
regex='exif:FocalLength: ([0-9]+)/([0-9]+)'
width_reg='exif:ExifImageWidth: ([0-9]+)'
id=0
echo "$directory"
for f in $directory; do 
exifoutput=$(identify -verbose $f | grep exif:);
eo=$(echo "$exifoutput" | grep exif:FocalLength:);
[[ $eo =~ $regex ]]
echo "$f"
echo "scale=3 ; ${BASH_REMATCH[1]} / ${BASH_REMATCH[2]}" | bc
ew=$(echo "$exifoutput" | grep exif:ExifImageWidth:);
[[ $ew =~ $width_reg ]]
echo "${BASH_REMATCH[1]}"
done


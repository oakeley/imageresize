#!/usr/bin/env bash
# Automatic folder creation and resizing of images (png by default) from a source watchface to a new target
# Edward J. Oakeley (draedie) 07-Jun-2024
#
## Depends on IMAGEMAGICK... To install imagemagick type the following commands from a "Debian/Ubuntu-like shell" (can be WSL)
# sudo apt update
# sudo apt upgrade -y
# sudo apt install imagemagick -y

# Usage: 
## Change terminal into the folder containing the "old" watchface. For example:
#   cd /home/edward/Working/zepp_v3.5/WFWD-Active-ColorV3_Zeppos3/assets/gts3
## Run resize script from that folder with either the full path to a new folder or the name of a new watchface in the current tree. Also provide a percentage scaling factor. <100% makes smaller. >100% makes bigger. This example makes images for falcon downsampled 80%. You could either type (if you want it in /home/edward/Working/zepp_v3.5/WFWD-Active-ColorV3_Zeppos3/assets/falcon):
#   bash resize.sh falcon 80 png
## ...or if you want everything somewhere else (folder "below" falcon must exist) you could type;
#   bash resize.sh /home/edward/Working/zepp_v3.5/resize/assets/falcon 80 png
# -------

# Step 1: Initialise everything
## Set output folder based on the first parameter
out=$1
## Set scaling facto based on the second parameter
scl=$2
## Set file type based on the third parameter. If it is blank then "png" will be used
img=`echo $3 | awk '{out="png"; if (length($0)>0) {out=$0}; print out}'`

# Step 2: Find all image files below current location ending with the letters in the variable "img" and make a tmp script to create new output folders. Errors for existing folders suppressed
echo "Making output folders..."
echo "mkdir "$out" 2> errors.txt" > .tmp.sh
find . | grep "$img"$ | awk -F"/" -v out=$out '{x=out; for (i=2; i<=(NF-1); i+=1) {x = x "/" $i; print "mkdir "x" 2>> errors.txt"}}' | sort | uniq >> .tmp.sh
## Execute commands
bash .tmp.sh

# Step 3: Resize all the selected image files by the "scl" scaling factor
echo "Resizing images..."
find . | grep "$img"$ | awk -F"/" -v out=$out -v scl=$scl '{scl=int(scl); x=out; for (i=2; i<=(NF-1); i+=1) {x = x "/" $i}; print "mogrify -path "x" -resize "scl"% -quality 100 "$0" 2>> errors.txt"}' > .tmp.sh
## Execute commands
bash .tmp.sh

# Step 4: Clean-up
echo "Check errors.txt if you think something went wrong. You can ignore \"cannot create directory... File exists\" and \"RGB color space not permitted on grayscale PNG\" warnings"
echo "****"
echo "Done"
rm .tmp.sh

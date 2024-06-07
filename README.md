# Image Resize

Depends on IMAGEMAGICK... To install imagemagick type the following commands from a "Debian/Ubuntu-like shell" (can be WSL)
 sudo apt update
 sudo apt upgrade -y
 sudo apt install imagemagick -y

# Usage: 
Change terminal into the folder containing the "old" watchface. For example:
 cd /home/edward/Working/zepp_v3.5/WFWD-Active-ColorV3_Zeppos3/assets/gts3
Run resize script from that folder with either the full path to a new folder or the name of a new watchface in the current tree. Also provide a percentage scaling factor.
<100% makes smaller. >100% makes bigger. 
This example makes images for falcon downsampled 80%. 
It will work if you type 80% or 80
Optional file extensions are case-sensitive
You could either type (if you want it in /home/edward/Working/zepp_v3.5/WFWD-Active-ColorV3_Zeppos3/assets/falcon):
## bash resize.sh falcon 80 png
...or if you want everything somewhere else (folder "below" falcon must exist) you could type;
## bash resize.sh /home/edward/Working/zepp_v3.5/resize/assets/falcon 80 png

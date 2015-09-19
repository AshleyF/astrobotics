#!/bin/bash

echo "Astrobotics capture" # tested on Canon 7D II

# 1) once focus (focus.sh) and other settings (experiment.sh) are determined...
# 2) choose a reasonable ISO setting
# 3) choose a reasonable shutter speed
# 4) choose a reasonable aperture
# 5) choose a number of exposures
# 6) have fun!

set -e

declare -a ISO=(100 125 160 200 250 320 400 500 640 800 1000 1250 1600 2000 2500 3200 4000 5000 6400 8000 10000 12800 16000)
echo "${ISO[@]}"
read -p "ISO Setting: " iso

declare -a Shutter=(30 25 20 15 13 10 8 6 5 4 3.2 2.5 2 1.6 1.3 1 0.8 0.6 0.5 0.4 0.3 1/4 1/5 1/6 1/8 1/10 1/13 1/15 1/20 1/25 1/30 1/40 1/50 1/60 1/80 1/100 1/125 1/160 1/200 1/250 1/320 1/400 1/500 1/640 1/800 1/1000 1/1250 1/1600 1/2000 1/2500 1/3200 1/4000 1/5000 1/6400 1/8000)
echo "${Shutter[@]}"
read -p "Shutter Setting: " shutter

# declare -a Aperture=(3.5 4 4.5 5 5.6 6.3 7.1 8 9 10 11 13 14 16 18 20 22)
declare -a Aperture=(5.6 6.3 7.1 8 9 10 11 13 14 16 18 20 22 25 29 32 36)
# use `gphoto2 --get-config aperture` to get available settings
echo "${Aperture[@]}"
read -p "Aperture Setting: " aperture

read -p "Number of Exposures: " number

transfer="no"
read -p "Transfer while capturing (default $transfer): " input
transfer="${input:-$transfer}"

read -p "Ready! (Remember to prime the camera)" input

rm -r capture/
mkdir capture/
gphoto2 --set-config imageformat="RAW"

echo "Setting ISO=$iso"
gphoto2 --set-config iso=$iso

echo "Setting Shutter=$shutter"
gphoto2 --set-config shutterspeed=$shutter

echo "Setting Aperture=$aperture"
gphoto2 --set-config aperture=$aperture

# capture
if [ "$transfer" != "no" ]; then
  for ((n=0; n<$number; n++)); do
    echo "Capturing #$n"
    gphoto2 --capture-image-and-download
    mv capt0000.cr2 capture/image$n.cr2
  done
else
  echo "Capturing #$number imeages on camera"
  gphoto2 --capture-image -F $number -I 1
fi

echo "Done!"

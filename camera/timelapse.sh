#!/bin/bash

echo "Timelapse capture" # tested on Canon 7D II

# 1) assumes "auto" settings
# 2) choose a number of exposures
# 3) have fun!

set -e

read -p "Number of Exposures: " number

interval=1
read -p "Interval seconds (default $interval): " input
interval="${input:-$interval}"

transfer="yes"
read -p "Transfer while capturing (default $transfer): " input
transfer="${input:-$transfer}"

read -p "Ready! (Remember to prime the camera)" input

rm -r timelapse/
mkdir timelapse/
gphoto2 --set-config imageformat="RAW"

# capture
if [ "$transfer" != "no" ]; then
  for ((n=1; n<=$number; n++)); do
    echo "Capturing #$n of $number"
    gphoto2 --capture-image-and-download --filename=capture.cr2
    mv capture.cr2 capture/image$n.cr2
    if [ $interval != 1 ]; then
      echo "Sleeping $interval..."
      sleep $interval
    fi
  done
else
  echo "Capturing #$number imeages on camera"
  gphoto2 --set-config capturetarget="Memory card"
  gphoto2 --capture-image -F $number -I $interval
fi

echo "Done!"

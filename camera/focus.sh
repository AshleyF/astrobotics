#!/bin/bash

echo "Astrobotics Star focus" # tested on Canon 7D II

# 1) set camera to manual, focused on "infinity", lense set to MF, stabalizer off
# 2) choose a reasonable ISO setting
# 3) choose a reasonable shutter speed
# 4) choose a reasonable aperture
# 5) choose focus step range
# 6) pick the best image
# 7) reset and run again with initial focus and pausing between experiments
# 8) abort when best focus is achieved
# 9) have fun!

set -e

# Auto 100 125 160 200 250 320 400 500 640 800 1000 1250 1600 2000 2500 3200 4000 5000 6400 8000 10000 12800 16000
iso="Auto"
read -p "ISO (default $iso): " input
iso="${input:-$iso}"

# 30 25 20 15 13 10 8 6 5 4 3.2 2.5 2 1.6 1.3 1 0.8 0.6 0.5 0.4 0.3 1/4 1/5 1/6 1/8 1/10 1/13 1/15 1/20 1/25 1/30
# 1/40 1/50 1/60 1/80 1/100 1/125 1/160 1/200 1/250 1/320 1/400 1/500 1/640 1/800 1/1000 1/1250 1/1600 1/2000
# 1/2500 1/3200 1/4000 1/5000 1/6400 1/8000
shutter="1/10"
read -p "Shutter speed (default $shutter): " input
shutter="${input:-$shutter}"

# 3.5 4 4.5 5 5.6 6.3 7.1 8 9 10 11 13 14 16 18 20 22 (EF-S 18-135, depending on zoom)
# use `gphoto2 --get-config aperture` to get available settings
aperture="5.6"
read -p "Aperture (default $aperture): " input
aperture="${input:-$aperture}"

focusinit=15
read -p "Initial focus (default $focusinit): " input
focusinit="${input:-$focusinit}"
focussteps=10
read -p "Focus steps (default $focussteps): " input
focussteps="${input:-$focussteps}"

pause="no"
read -p "Pause between experiments (default $pause): " input
pause="${input:-$pause}"

read -p "Ready! (Remember to prime the camera and to set focus to infinity)" input

echo "Setting ISO=$iso"
gphoto2 --set-config iso=$iso

echo "Setting shutter=$shutter"
gphoto2 --set-config shutterspeed=$shutter

echo "Setting aperture=$aperture"
gphoto2 --set-config aperture=$aperture

echo "Setting (temporary) imageformat=JPEG"
gphoto2 --set-config imageformat="Large Fine JPEG" # set back to RAW later

echo "Setting focusmode=Manual - lense must be set to MF"
gphoto2 --set-config focusmode="Manual"
   
echo "Capturing test preview"
gphoto2 --force-overwrite --capture-preview # manualfocusdrive doesn't work otherwise?!
rm capture_preview.jpg 
rm -r focus/
mkdir focus/

echo "Achieving initial focus"
f=0
while [ $f -le $focusinit ]; do
  echo "Initial step Focus=$f"
  gphoto2 --set-config-value /main/actions/manualfocusdrive="Near 1"
  f=$(($f+1))
done

echo "Running focus experiment"
while [ $f -le $(($focusinit+$focussteps)) ]; do
  echo "Capturing Focus=$f"
  gphoto2 --capture-image-and-download
  mv capt0000.jpg focus/focus$f.jpg
  if [ "$pause" != "no" ]; then
    read -p "Continue (default 'yes')?" input
    if [ "$input" != "" ]; then
      echo "Setting imageformat=RAW"
      gphoto2 --set-config imageformat="RAW"
      echo "Aborted"
      exit 0
    fi
  fi
  gphoto2 --set-config-value /main/actions/manualfocusdrive="Near 1"
  f=$(($f+1))
done

# finish
echo "Setting imageformat=RAW"
gphoto2 --set-config imageformat="RAW"

echo "Done!"

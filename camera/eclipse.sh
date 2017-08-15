#!/bin/bash

echo "Astrobotics Eclipse" # tested on Canon 7D II & 5D IV

# 1) set camera to manual, lense set to MF, stabalizer off
# 2) choose a reasonable ISO min/max setting
# 3) choose a reasonable min/max shutter speed
# 4) choose a reasonable min/max aperture
# 5) have fun!

declare -a ISO=(100 125 160 200 250 320 400 500 640 800 1000 1250 1600 2000 2500 3200 4000 5000 6400 8000 10000 12800 16000)
echo "ISO Settings:"
for ((i=0; i<${#ISO[@]}; i++)); do
   echo "$i) ${ISO[i]}"
done
read -p "Minimum ISO: " minISO
read -p "Maximum ISO: " maxISO

declare -a Shutter=(30 25 20 15 13 10 8 6 5 4 3.2 2.5 2 1.6 1.3 1 0.8 0.6 0.5 0.4 0.3 1/4 1/5 1/6 1/8 1/10 1/13 1/15 1/20 1/25 1/30 1/40 1/50 1/60 1/80 1/100 1/125 1/160 1/200 1/250 1/320 1/400 1/500 1/640 1/800 1/1000 1/1250 1/1600 1/2000 1/2500 1/3200 1/4000 1/5000 1/6400 1/8000)
echo "Shutter Settings:"
for ((s=0; s<${#Shutter[@]}; s++)); do
   echo "$s) ${Shutter[s]}"
done
read -p "Minimum Shutter: " minShutter
read -p "Maximum Shutter: " maxShutter

declare -a Aperture=(2.8 3.5 4 4.5 5 5.6 6.3 7.1 8 9 10 11 13 14 16 18 20 22)
# use `gphoto2 --get-config aperture` to get available settings
echo "Aperture Settings:"
for ((a=0; a<${#Aperture[@]}; a++)); do
   echo "$a) ${Aperture[a]}"
done
read -p "Minimum Aperture: " minAperture
read -p "Maximum Aperture: " maxAperture

read -p "Ready! (Remember to prime the camera)" input

# capture images!
while true
do
  for ((i=$minISO; i<=$maxISO; i++)); do
    iso=${ISO[i]}
    echo "Setting ISO=$iso"
    gphoto2 --set-config iso=$iso
    for ((s=$minShutter; s<=$maxShutter; s++)); do
      shutter=${Shutter[s]}
      echo "Setting Shutter=$shutter"
      gphoto2 --set-config shutterspeed=$shutter
      for ((a=$minAperture; a<=$maxAperture; a++)); do
        aperture=${Aperture[a]}
        echo "Setting Aperture=$aperture"
        gphoto2 --set-config aperture=$aperture
        echo "Capturing ISO=$iso Shutter=$shutter Aperture=$aperture"
        gphoto2 --capture-image
      done
    done
  done
  sleep 1s
done

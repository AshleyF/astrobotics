# capture images!
# tested on Canon 7D II

# once focus (focus.sh) and other settings (experiment.sh) are determined...
# choose a reasonable ISO range
# choose a reasonable shutter speed range
# choose a reasonable aperture range (wide open?)
# run this
# pick the best image
# have fun!

# prepare
gphoto2 --set-config imageformat=0 # set back to RAW later
gphoto2 --force-overwrite --capture-preview # manualfocusdrive doesn't work otherwise?!
rm capture_preview.jpg 
rm -r capture/
mkdir capture/

# focus
echo "Focusing..."
# for f in {0..11} # set this based on earlier findings
# do
#   gphoto2 --set-config-value /main/actions/manualfocusdrive="Near 1"
# done

# ISO
# 0=Auto 1=100 2=125 3=160 4=200 5=250 6=320 7=400 8=500 9=640 10=800
# 11=1000 12=1250 13=1600 14=2000 15=2500 16=3200 17=4000 18=5000 19=6400
# 20=8000 21=10000 22=12800 23=16000
gphoto2 --set-config iso=13

# Shutter Speed
# 0=30 1=25 2=20 3=15 4=13 5=10 6=8 7=6 8=5 9=4 10=3.2 11=2.5 12=2 13=1.6
# 14=1.3 15=1 16=0.8 17=0.6 18=0.5 19=0.4 20=0.3 21=1/4 22=1/5 23=1/6 24=1/8
# 25=1/10 26=1/13 27=1/15 28=1/20 29=1/25 30=1/30 31=1/40 32=1/50 33=1/60
# 34=1/80 35=1/100 36=1/125 37=1/160 38=1/200 39=1/250 40=1/320 41=1/400
# 42=1/500 43=1/640 44=1/800 45=1/1000 46=1/1250 47=1/1600 48=1/2000 49=1/2500
# 50=1/3200 51=1/4000 52=1/5000 53=1/6400 54=1/8000
gphoto2 --set-config shutterspeed=15

# aperture
# 0=2.8 1=3.2 2=3.5 3=4 4=4.5 5=5 6=5.6 7=6.3 8=7.1 9=8 10=9 11=10 12=11 13=13
# 14=14 15=16 16=18 17=20 18=22
gphoto2 --set-config aperture=0

# capture
for n in {0..0}
do
  echo "Capturing #$n"
  gphoto2 --capture-image-and-download
  mv capt0000.jpg capture/image$n.jpg
done

# finish
gphoto2 --set-config imageformat=32 # RAW

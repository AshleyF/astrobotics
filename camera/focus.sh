# star focus!
# tested on Canon 7D II

# set camera to manual with infinity focus
# choose a reasonable ISO/shutter/aperture setting
# choose focus step range
# run this
# pick the best image
# have fun!

# ISO
# 0=Auto 1=100 2=125 3=160 4=200 5=250 6=320 7=400 8=500 9=640 10=800
# 11=1000 12=1250 13=1600 14=2000 15=2500 16=3200 17=4000 18=5000 19=6400
# 20=8000 21=10000 22=12800 23=16000
gphoto2 --set-config iso=5

# Shutter Speed
# 0=30 1=25 2=20 3=15 4=13 5=10 6=8 7=6 8=5 9=4 10=3.2 11=2.5 12=2 13=1.6
# 14=1.3 15=1 16=0.8 17=0.6 18=0.5 19=0.4 20=0.3 21=1/4 22=1/5 23=1/6 24=1/8
# 25=1/10 26=1/13 27=1/15 28=1/20 29=1/25 30=1/30 31=1/40 32=1/50 33=1/60
# 34=1/80 35=1/100 36=1/125 37=1/160 38=1/200 39=1/250 40=1/320 41=1/400
# 42=1/500 43=1/640 44=1/800 45=1/1000 46=1/1250 47=1/1600 48=1/2000 49=1/2500
# 50=1/3200 51=1/4000 52=1/5000 53=1/6400 54=1/8000
gphoto2 --set-config shutterspeed=25

# aperture
# 0=2.8 1=3.2 2=3.5 3=4 4=4.5 5=5 6=5.6 7=6.3 8=7.1 9=8 10=9 11=10 12=11 13=13
# 14=14 15=16 16=18 17=20 18=22
gphoto2 --set-config aperture=0

# manual focus drive
# 0=Near1 1=Near2 2=Near3 3=None 4=Far1 5=Far2 6=Far3

# image format
# 0=Large_Fine_JPEG 1=Large_Normal_JPEG 2=Medium_Fine_JPEG 3=Medium_Normal_JPEG
# 4=Small_Fine_JPEG_(S1_Fine) 5=Small_Normal_JPEG_(S1_Normal)
# 6=Smaller_JPEG_(S2) 7=Tiny_JPEG_(S3) 8=RAW_+_Large_Fine_JPEG
# 9=RAW_+_Large_Normal_JPEG 10=RAW_+_Medium_Fine_JPEG
# 11=RAW_+_Medium_Normal_JPEG 12=RAW_+_Small_Fine_JPEG_(S1_Fine)
# 13=RAW_+_Small_Normal_JPEG_(S1_Normal) 14=RAW_+_Smaller_JPEG_(S2)
# 15=RAW_+_Tiny_JPEG_(S3) 16=mRAW_+_Large_Fine_JPEG 17=mRAW_+_Large_Normal_JPEG
# 18=mRAW_+_Medium_Fine_JPEG 19=mRAW_+_Medium_Normal_JPEG
# 20=mRAW_+_Small_Fine_JPEG_(S1_Fine) 21=mRAW_+_Small_Normal_JPEG_(S1_Normal)
# 22=mRAW_+_Smaller_JPEG_(S2) 23=mRAW_+_Tiny_JPEG_(S3) 24=sRAW_+_Large_Fine_JPEG
# 25=sRAW_+_Large_Normal_JPEG 26=sRAW_+_Medium_Fine_JPEG
# 27=sRAW_+_Medium_Normal_JPEG 28=sRAW_+_Small Fine_JPEG_(S1_Fine)
# 29=sRAW_+_Small_Normal_JPEG_(S1_Normal) 30=sRAW_+_Smaller_JPEG_(S2)
# 31=sRAW_+_Tiny_JPEG_(S3) 32=RAW 33=mRAW 34=sRAW
gphoto2 --set-config imageformat=0 # set back to RAW later

# prepare
gphoto2 --set-config focusmode=3 # manual
gphoto2 --force-overwrite --capture-preview # manualfocusdrive doesn't work otherwise?!
rm capture_preview.jpg 
rm -r focus/
mkdir focus/

# experiment
for f in {0..20}
do
  echo "Capturing Focus=-$f"
  gphoto2 --capture-image-and-download
  mv capt0000.jpg focus/focus$f.jpg
  gphoto2 --set-config-value /main/actions/manualfocusdrive="Near 1"
done

# finish
gphoto2 --set-config imageformat=32 # RAW

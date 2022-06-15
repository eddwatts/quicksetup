#!/usr/bin/python3
import RPi.GPIO as GPIO
import time
from datetime import datetime
import os
imgrotation=0
pictime=2
picstrore='/mnt/samba/timelaps/'

path='/mnt/ramdisk'
currentTime = int
picno=0
pictime=(pictime*60)-6
oldtime = time.time()-(1000+pictime)
now = datetime.now()
d1=now.strftime("%Y%m%d%H%M")
path = os.path.join(picstrore,d1)
GPIO.setmode(GPIO.BCM)
GPIO.setup(24, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(25, GPIO.IN, pull_up_down=GPIO.PUD_UP)

GPIO.setup(18, GPIO.OUT) # LED pin set as output
GPIO.setup(23, GPIO.OUT) # PWM pin set as output
GPIO.output(18, GPIO.HIGH)
GPIO.output(23, GPIO.HIGH)

def capture(ab):
    global picno
    global oldtime
    global path
    if time.time() - oldtime > pictime + 600:
        print("Reset Image counter and start new timelapes")
        now = datetime.now()
        d1=now.strftime("%Y%m%d%H%M")
        path = os.path.join(picstrore,d1)
        os.mkdir(path)
        picno=0
    oldtime = time.time()
    currentTime = int(round(time.time() * 1000))
    img_path=path+"/"+str(picno).zfill(8)+".jpg"
    picno=picno+1
    if os.path.exists(path+ '/camlock.ok')
      time.sleep(6)
    f = open(path+ "/camlock.ok", "a")
    f.write("camera in use")
    f.close()
    GPIO.output(18, GPIO.LOW)
    GPIO.output(23, GPIO.LOW)
    os.system("libcamera-still -t 5000 -o " + img_path +  " --autofocus -q 100 --rawfull --rotation " + imgrotation + " -n")
    print(img_path)
    GPIO.output(18, GPIO.HIGH)
    GPIO.output(23, GPIO.HIGH)
    os.remove(path+ "/camlock.ok")
GPIO.add_event_detect(24, GPIO.FALLING, callback=capture, bouncetime=1000)
GPIO.add_event_detect(25, GPIO.RISING, callback=capture, bouncetime=5000)
while 1:
    if pictime > 1:
        capture(99)
    time.sleep(pictime)

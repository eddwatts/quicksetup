#!/usr/bin/python3
import RPi.GPIO as GPIO
import time
from datetime import datetime
import os
import configparser
import syslog
config = configparser.ConfigParser()
config.read('/boot/settings.ini')
pictime=int(config['TIMELAPSE']['PicTime'])
picstrore=config['TIMELAPSE']['PicStrore']
path1='/mnt/ramdisk'
currentTime = int
picno=0
syslog.syslog("delay startup for network to fix 30")
time.sleep(10)
syslog.syslog("delay startup for network to fix 20")
time.sleep(10)
syslog.syslog("delay startup for network to fix 10")
time.sleep(10)
pictime=(pictime*60)-6
oldtime = time.time()-(1000+pictime)
now = datetime.now()
d1=now.strftime("%Y%m%d%H%M")
path = os.path.join(picstrore,d1)
GPIO.setwarnings(False)
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
    global picstrore
    global imgrotation
    global LCSE
    if time.time() - oldtime > pictime + 600:
        syslog.syslog("Reset Image counter and start new timelapes")
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
    if os.path.exists(path1+ '/camlock.ok'):
      time.sleep(6)
    f = open(path1+ "/camlock.ok", "a")
    f.write("camera in use")
    f.close()
    if os.path.exists(path1+ '/Pic.jpg'):
        os.remove(path1+ "/Pic.jpg")
    GPIO.output(18, GPIO.LOW)
    GPIO.output(23, GPIO.LOW)
    syslog.syslog("taking Photo")
    os.system("libcamera-still -t 5000 -o " + path1 + "/Pic.jpg -q " + config['TIMELAPSE']['ImgQuality'] + " --rawfull --rotation " + config['TIMELAPSE']['ImgRotation'] + " -n --denoise " + config['TIMELAPSE']['Denoise'] + " " + config['TIMELAPSE']['libcamera-still-extra'])
    GPIO.output(18, GPIO.HIGH)
    GPIO.output(23, GPIO.HIGH)
    syslog.syslog("Copy photo to network")
    os.system("cp " + path1 + "/Pic.jpg " +  img_path)
    syslog.syslog(img_path)
    print(img_path)
    os.remove(path1+ "/camlock.ok")
GPIO.add_event_detect(24, GPIO.FALLING, callback=capture, bouncetime=1000)
GPIO.add_event_detect(25, GPIO.RISING, callback=capture, bouncetime=5000)
while 1:
    if pictime > 1:
        capture(99)
    time.sleep(pictime)

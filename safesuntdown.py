#!/usr/bin/python3
import RPi.GPIO as GPIO
import time
from datetime import datetime
import os

GPIO.setmode(GPIO.BCM)
GPIO.setup(21, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(13, GPIO.IN, pull_up_down=GPIO.PUD_UP)

def Shutdown(channel):
    print("Shutting Down")
    bot.sendMessage(masterchat,'Shutting Down ' + piname)
    time.sleep(5)
    os.system("sudo shutdown -h now")

def Reboot(channel):
    print("Shutting Down")
    bot.sendMessage(masterchat,'Rebooting ' + piname)
    time.sleep(1)
    os.system("sudo shutdown -r now")

GPIO.add_event_detect(21, GPIO.FALLING, callback=Shutdown, bouncetime=2000)
GPIO.add_event_detect(13, GPIO.FALLING, callback=Reboot, bouncetime=2000)

while 1:
    time.sleep(10)

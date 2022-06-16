#!/usr/bin/python3
import time
from datetime import datetime
import os
import telepot
import socket
import configparser
config = configparser.ConfigParser()
config.read('/boot/settings.ini')
bot = telepot.Bot(config['TELEGRAM']['BOT'])
masterchat=config['TELEGRAM']['Masterchat']
MyPass=config['TELEGRAM']['passme']
imgrotation=config['TIMELAPSE']['ImgRotation']
LCSE=config['TIMELAPSE']['libcamera-still-extra']
ImgQ=config['TELEGRAM']['ImgQuality']
path='/mnt/ramdisk'
piname=socket.gethostname().lower()
def handle(msg):
    chat_id = msg['chat']['id']
    command = msg['text']
    print('Got command: %s' % command)
    if (command == '/whoiswho'):
      bot.sendMessage(chat_id, piname + ' ' online')
    elif (command == '/reboot ' + MyPass + ' + piname):
      bot.sendMessage(chat_id,'Rebooting ' + piname)
      time.sleep(1)
      os.system('sudo shutdown -r now')
    elif (command == '/shutdown ' + MyPass + ' ' + piname):
      bot.sendMessage(chat_id,'Shutting Down ' + piname)
      time.sleep(1)
      os.system("sudo shutdown -h now")
    elif (command == '/photo ' + MyPass + ' ' + piname):
          
      bot.sendMessage(chat_id, 'Getting photo')
      if os.path.exists(path+ '/camlock.ok')
        time.sleep(6)
      f = open(path+ "/camlock.ok", "a")
      f.write("camera in use")
      f.close()
      os.system("libcamera-still -t 2000 -o " + path + "/Pic.jpg -q " + ImgQ + " --rawfull --rotation " + imgrotation + " -n " + LCSE)
      os.remove(path+ "/camlock.ok")

      bot.sendMessage(chat_id, 'sending photo')
      bot.sendPhoto(chat_id, open(path + '/Pic.jpg', 'rb'))
bot.message_loop(handle)
print(piname + ' online...')
bot.sendMessage(masterchat, piname + ' online')

while 1:
    time.sleep(10)

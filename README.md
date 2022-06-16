<h1>quicksetup</h1>
bash <(curl -s https://raw.githubusercontent.com/eddwatts/quicksetup/main/setupme.sh?id=$RANDOM)

bash <(curl -s https://raw.githubusercontent.com/eddwatts/quicksetup/main/maketimelapse.sh?id=$RANDOM)

configeration ini file stored on /boot for ease of change while powerd off.

<h1>Watchdog</h1>
watchdog setup with timeout of 15s, max load of 24, wireless interface check, ping check of 1.1.1.1, running in real time.<br>
watchdog not enabled as default untill checked working on a pi

lsmod | grep wd<br>
ls -la /dev/watchdog*

sudo systemctl enable watchdog<br>
sudo systemctl start watchdog<br>
sudo systemctl status watchdog<br>

<h1>Read-Only Raspberry Pi</h1>

sudo raspi-config<br>
Navigate down to “Performance Options” and then “Overlay File System.” Select “Yes” to both the enable and write-protect questions.<br>
It may take a minute or more while the system works, this is normal. Tab to the “Finish” button and reboot when prompted.<br>

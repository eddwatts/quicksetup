# quicksetup
bash <(curl -s https://raw.githubusercontent.com/eddwatts/quicksetup/main/setupme.sh?id=$RANDOM)

bash <(curl -s https://raw.githubusercontent.com/eddwatts/quicksetup/main/maketimelapse.sh?id=$RANDOM)

configeration ini file stored on /boot for ease of change while powerd off.

Read-Only Raspberry Pi

sudo raspi-config
Navigate down to “Performance Options” and then “Overlay File System.” Select “Yes” to both the enable and write-protect questions.

It may take a minute or more while the system works, this is normal. Tab to the “Finish” button and reboot when prompted.


watchdog setup with timeout of 15s, max load of 24, wireless interface check, ping check of 1.1.1.1, running in real time.
watchdog not enabled as default untill checked working on a pi

lsmod | grep wd

ls -la /dev/watchdog*

sudo systemctl enable watchdog
sudo systemctl start watchdog
sudo systemctl status watchdog

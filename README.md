# quicksetup
bash <(curl -s https://raw.githubusercontent.com/eddwatts/quicksetup/main/setupme.sh?id=$RANDOM)

bash <(curl -s https://raw.githubusercontent.com/eddwatts/quicksetup/main/maketimelapse.sh?id=$RANDOM)

Read-Only Raspberry Pi

sudo raspi-config
Navigate down to “Performance Options” and then “Overlay File System.” Select “Yes” to both the enable and write-protect questions.

It may take a minute or more while the system works, this is normal. Tab to the “Finish” button and reboot when prompted.

lsmod | grep wd
ls -la /dev/watchdog*



/etc/systemd/system.conf

RuntimeWatchdogSec=2min
RebootWatchdogSec=1min
DefaultTimeoutStopSec=10s
WatchdogDevice


#Includes support for: (removed for internal)
#https://thepihut.com/products/piwatcher-tb-terminal-block-version

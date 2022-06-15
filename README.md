# quicksetup
bash <(curl -s https://raw.githubusercontent.com/eddwatts/quicksetup/main/setupme.sh?id=$RANDOM)

bash <(curl -s https://raw.githubusercontent.com/eddwatts/quicksetup/main/maketimelapse.sh?id=$RANDOM)

Read-Only Raspberry Pi

sudo raspi-config
Navigate down to “Performance Options” and then “Overlay File System.” Select “Yes” to both the enable and write-protect questions.

It may take a minute or more while the system works, this is normal. Tab to the “Finish” button and reboot when prompted.

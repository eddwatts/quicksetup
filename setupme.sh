sudo mkdir /mnt/ramdisk
echo 'tmpfs /mnt/ramdisk tmpfs nodev,nosuid,size=20M 0 0' | sudo tee --append /etc/fstab
sudo mount -a
echo '[Unit]' | sudo tee --append /etc/systemd/system/telepotcontrol.service
echo 'Description=My Script' | sudo tee --append /etc/systemd/system/telepotcontrol.service
echo '' | sudo tee --append /etc/systemd/system/telepotcontrol.service
echo '[Service]' | sudo tee --append /etc/systemd/system/telepotcontrol.service
echo 'ExecStart=/usr/bin/python3 /home/telepotcontrol.py' | sudo tee --append /etc/systemd/system/telepotcontrol.service
echo '' | sudo tee --append /etc/systemd/system/telepotcontrol.service
echo '[Install]' | sudo tee --append /etc/systemd/system/telepotcontrol.service
echo 'WantedBy=multi-user.target' | sudo tee --append /etc/systemd/system/telepotcontrol.service
echo '[Unit]' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo 'Description=My Script' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo '' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo '[Service]' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo 'ExecStart=/usr/bin/python3 /home/safeshutdown.py' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo '' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo '[Install]' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo 'WantedBy=multi-user.target' | sudo tee --append /etc/systemd/system/safeshutdown.service
sudo curl -o "/home/telepotcontrol.py" "https://raw.githubusercontent.com/eddwatts/quicksetup/main/telepotcontrol.py?id=$RANDOM" -L
sudo curl -o "/home/safeshutdown.py" "https://raw.githubusercontent.com/eddwatts/quicksetup/main/safesuntdown.py?id=$RANDOM" -L

sudo raspi-config nonint do_memory_split 128
sudo raspi-config nonint do_camera 0
sudo raspi-config nonint do_ssh 1
sudo raspi-config nonint do_i2c 1
sudo raspi-config nonint do_boot_wait 1
sudo raspi-config nonint do_configure_keyboard gb
sudo raspi-config nonint do_wifi_country GB
sudo raspi-config nonint do_change_timezone Eurpoe/London
sudo raspi-config nonint do_change_locale en_GB.UTF-8
sudo apt-get update
sudo apt-get -y install python3-pip
pip3 install telepot

sudo systemctl start safeshutdown    # Runs the script now
sudo systemctl enable safeshutdown   # Sets the script to run every boot
sudo systemctl start telepotcontrol    # Runs the script now
sudo systemctl enable telepotcontrol   # Sets the script to run every boot

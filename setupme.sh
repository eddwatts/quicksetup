echo 'dtparam=watchdog=on' | sudo tee --append /boot/config.txt
echo 'dtoverlay=vc4-kms-v3d,cma-128' | sudo tee --append /boot/config.txt
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
sudo curl -o "/boot/settings.ini" "https://raw.githubusercontent.com/eddwatts/quicksetup/main/settings.ini?id=$RANDOM" -L
sudo curl -o "/home/install_pivariety_pkgs.sh" "https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver/releases/download/install_script/install_pivariety_pkgs.sh" -L
chmod +x /home/install_pivariety_pkgs.sh

sudo apt-get update
sudo apt-get -y install python3-pip watchdog gldriver-test libdrm-amdgpu1 libdrm-nouveau2 libdrm-radeon1 libgl1-mesa-dri libglapi-mesa libllvm11 libsensors-config libsensors5 libvulkan1 libwayland-client0 libx11-xcb1 libxcb-dri3-0 libxcb-present0 libxcb-randr0 libxcb-sync1 libxshmfence1 libz3-4 mesa-vulkan-drivers


#/home/install_pivariety_pkgs.sh -p libcamera_dev
#/home/install_pivariety_pkgs.sh -p libcamera_apps
#/home/install_pivariety_pkgs.sh -p imx519_kernel_driver
#/home/install_pivariety_pkgs.sh -p 64mp_pi_hawk_eye_kernel_driver
#git clone https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver.git



sudo raspi-config nonint do_memory_split 128
sudo raspi-config nonint do_camera 0
sudo raspi-config nonint do_ssh 0
sudo raspi-config nonint do_i2c 0
sudo raspi-config nonint do_boot_wait 0
sudo raspi-config nonint do_configure_keyboard gb
sudo raspi-config nonint do_wifi_country GB
sudo raspi-config nonint do_change_timezone Eurpoe/London
sudo raspi-config nonint do_change_locale en_GB.UTF-8
sudo raspi-config nonint do_gldriver G2
sudo raspi-config nonint do_glamor 0

sudo pip3 -q install telepot twython --upgrade
echo 'watchdog-device = /dev/watchdog' | sudo tee --append /etc/watchdog.conf
echo 'watchdog-timeout = 15' | sudo tee --append /etc/watchdog.conf
echo 'max-load-1 = 24' | sudo tee --append /etc/watchdog.conf
echo 'interface = wlan0' | sudo tee --append /etc/watchdog.conf
#echo 'ping = 1.1.1.1' | sudo tee --append /etc/watchdog.conf
echo 'realtime = yes' | sudo tee --append /etc/watchdog.conf

sudo systemctl start safeshutdown    # Runs the script now
sudo systemctl enable safeshutdown   # Sets the script to run every boot
sudo systemctl start telepotcontrol    # Runs the script now
sudo systemctl enable telepotcontrol   # Sets the script to run every boot
#sudo systemctl enable watchdog
#sudo systemctl start watchdog


#lsmod | grep wd
#ls -la /dev/watchdog*

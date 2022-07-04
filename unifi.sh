echo 'dtparam=watchdog=on' | sudo tee --append /boot/config.txt
echo 'dtoverlay=vc4-kms-v3d,cma-128' | sudo tee --append /boot/config.txt
echo 'disable_camera_led=1' | sudo tee --append /boot/config.txt
sudo raspi-config nonint do_boot_wait 0
sudo raspi-config nonint do_memory_split 128
sudo raspi-config nonint do_camera 0
sudo raspi-config nonint do_ssh 0
sudo raspi-config nonint do_i2c 0
sudo raspi-config nonint do_boot_wait 0
sudo raspi-config nonint do_configure_keyboard gb
sudo raspi-config nonint do_wifi_country GB
sudo raspi-config nonint do_change_timezone Eurpoe/London
sudo raspi-config nonint do_change_locale en_GB.UTF-8
echo '[Unit]' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo 'Description=Shutdown service' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo '' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo '[Service]' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo 'ExecStart=/usr/bin/python3 /home/safeshutdown.py' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo '' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo '[Install]' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo 'WantedBy=multi-user.target' | sudo tee --append /etc/systemd/system/safeshutdown.service
sudo curl -o "/home/safeshutdown.py" "https://raw.githubusercontent.com/eddwatts/quicksetup/main/safesuntdown.py?id=$RANDOM" -L
sudo apt-get update && sudo apt-get install ca-certificates apt-transport-https
echo 'deb [signed-by=/usr/share/keyrings/ubiquiti-archive-keyring.gpg] https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
curl https://dl.ui.com/unifi/unifi-repo.gpg | sudo tee /usr/share/keyrings/ubiquiti-archive-keyring.gpg >/dev/null
echo '#Never Prefer packages from Stretch' | sudo tee --append /etc/apt/preferences.d/99stretch-mongodb.pref
echo 'Package: *' | sudo tee --append /etc/apt/preferences.d/99stretch-mongodb.pref
echo 'Pin: release n=stretch' | sudo tee --append /etc/apt/preferences.d/99stretch-mongodb.pref
echo 'Pin-Priority: 1' | sudo tee --append /etc/apt/preferences.d/99stretch-mongodb.pref
echo 'deb http://archive.raspbian.org/raspbian stretch main contrib non-free rpi' | sudo tee /etc/apt/sources.list.d/raspbian_stretch_for_mongodb.list
sudo apt install openjdk-8-jre-headless jsvc libcommons-daemon-java rng-tools mongodb-server mongodb-clients rsync -y
sed -i 's/#HRNGDEVICE=/HRNGDEVICE=/' /etc/default/rng-tools-debian
sudo systemctl restart rng-tools
#sudo nano /etc/iptables.firewall.rules
echo '*filter' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -i lo -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -d 127.0.0.0/8 -j REJECT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -p icmp --icmp-type echo-request -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -p tcp -m multiport –dports 8080,443,8443,8843,6789 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -p udp --dport 3478 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -s 192.168.1.0/24 -p udp --dport 5514 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -s 192.168.1.0/24 -p tcp --dport 22 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -p tcp -s 192.168.1.0/24 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -s 192.168.1.0/24 -p tcp --dport 8880 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -s 192.168.1.0/24 -p tcp --dport 27117 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -s 192.168.1.0/24 -p udp --dport 10001 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -s 192.168.1.0/24 -p udp --dport 1900 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -s 192.168.1.0/24 -p udp --dport 5656:5699 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT 1 -s 192.168.1.0/24 -p tcp -m tcp --dport 80 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT 1 -s 127.0.0.0/8 -p tcp -m tcp --dport 53 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT 1 -s 127.0.0.0/8 -p udp -m udp --dport 53 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT 1 -s 192.168.1.0/24 -p tcp -m tcp --dport 53 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT 1 -s 192.168.1.0/24 -p udp -m udp --dport 53 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT 1 -p udp --dport 67:68 --sport 67:68 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT 1 -p tcp -m tcp --dport 4711 -i lo -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A OUTPUT -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -j DROP' | sudo tee --append /etc/iptables.firewall.rules
echo '-A FORWARD -j DROP' | sudo tee --append /etc/iptables.firewall.rules
sudo iptables-restore < /etc/iptables.firewall.rules
cho 'watchdog-device = /dev/watchdog' | sudo tee --append /etc/watchdog.conf
echo 'watchdog-timeout = 15' | sudo tee --append /etc/watchdog.conf
echo 'max-load-1 = 24' | sudo tee --append /etc/watchdog.conf
echo 'interface = eth0' | sudo tee --append /etc/watchdog.conf
echo 'ping = 1.1.1.1' | sudo tee --append /etc/watchdog.conf
echo 'realtime = yes' | sudo tee --append /etc/watchdog.conf
wget https://github.com/azlux/log2ram/archive/master.tar.gz -O log2ram.tar.gz
tar xf log2ram.tar.gz
#sudo nano /etc/log2ram.conf
#PATH_DISK="/var/log";"/usr/lib/unifi/logs"
sed -i 's/PATH_DISK="//var//log"/PATH_DISK="//var//log";"//usr//lib//unifi//logs"/' /etc/log2ram.conf
sed -i 's/SIZE=40M/SIZE=80M/' /etc/log2ram.conf
cd /home/pi/log2ram-master
sudo ./install.sh
sudo systemctl start safeshutdown    # Runs the script now
sudo systemctl enable safeshutdown   # Sets the script to run every boot
sudo systemctl enable watchdog
sudo systemctl start watchdog
sudo apt install unifi
#sleep 10
#curl -sSL https://install.pi-hole.net | bash
#pihole -a -p


#/etc/dhcpcd.conf
#interface eth0
#static ip_address=myip
#static routers=mygw
#static domain_name_servers=1.1.1.3
#sudo /etc/init.d/networking restart
#sleep 10
#sudo /etc/init.d/networking reload

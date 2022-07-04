raspi-config nonint do_boot_wait 0
echo '#Never Prefer packages from Stretch' | sudo tee --append /etc/apt/preferences.d/99stretch-mongodb.pref
echo 'Package: *' | sudo tee --append /etc/apt/preferences.d/99stretch-mongodb.pref
echo 'Pin: release n=stretch' | sudo tee --append /etc/apt/preferences.d/99stretch-mongodb.pref
echo 'Pin-Priority: 1' | sudo tee --append /etc/apt/preferences.d/99stretch-mongodb.pref
echo "deb http://archive.raspbian.org/raspbian stretch main" | sudo tee /etc/apt/sources.list.d/stretch_mongodb.list
echo 'deb [signed-by=/usr/share/keyrings/ubiquiti-archive-keyring.gpg] https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
curl https://dl.ui.com/unifi/unifi-repo.gpg | sudo tee /usr/share/keyrings/ubiquiti-archive-keyring.gpg >/dev/null
#sudo nano /etc/iptables.firewall.rules
echo '*filter' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -i lo -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -d 127.0.0.0/8 -j REJECT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -p icmp --icmp-type echo-request -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -p tcp -m multiport –dports 8080,443,8443,8843,6789 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -p udp --dport 3478 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -s 192.168.1.0/24 -p udp --dport 5514 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -s 192.168.1.0/24 -p tcp --dport 8880 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -s 192.168.1.0/24 -p tcp --dport 27117 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -s 192.168.1.0/24 -p udp --dport 10001 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -s 192.168.1.0/24 -p udp --dport 1900 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -s 192.168.1.0/24 -p udp --dport 5656:5699 -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A OUTPUT -j ACCEPT' | sudo tee --append /etc/iptables.firewall.rules
echo '-A INPUT -j DROP' | sudo tee --append /etc/iptables.firewall.rules
echo '-A FORWARD -j DROP' | sudo tee --append /etc/iptables.firewall.rules
sudo iptables-restore < /etc/iptables.firewall.rules
sudo apt update
sudo apt upgrade
sudo apt install -y openjdk-8-jre-headless rng-tools
sed -i 's/#HRNGDEVICE=/HRNGDEVICE=/' /etc/default/rng-tools-debian
sudo systemctl restart rng-tools
sudo apt install unifi

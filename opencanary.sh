#!/bin/bash
//https://github.com/thinkst/opencanary
//https://www.youtube.com/watch?v=RanpEQBvAY0
//https://bobmckay.com/i-t-support-networking/hardware/create-a-security-honey-pot-with-opencanary-and-a-raspberry-pi-3-updated-2021/

read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -p "clearing buffer" -t 1 -n 10000 discard
echo -ne "\033c"
read -p "Email from: " emailfrom
read -p "Email login: " emailuser
read -p "password for email: " emailpass
read -p "alert email: " emailalert
read -p "type hostname for this device: " hostname

//sudo raspi-config nonint do_ssh 0
//sudo raspi-config nonint do_i2c 0
//sudo raspi-config nonint do_boot_wait 0
//sudo raspi-config nonint do_configure_keyboard gb
//sudo raspi-config nonint do_change_timezone Eurpoe/London
//sudo raspi-config nonint do_change_locale en_GB.UTF-8
//sudo raspi-config nonint do_gldriver G2
//sudo raspi-config nonint do_glamor 0
//echo 'dtoverlay=pi3-disable-wifi' | sudo tee --append /boot/config.txt
//echo 'dtoverlay=pi3-disable-bt' | sudo tee --append /boot/config.txt
//echo 'RuntimeWatchdogSec=14' | sudo tee --append /etc/systemd/system.conf
//echo 'ShutdownWatchdogSec=2min' | sudo tee --append /etc/systemd/system.conf
//sudo mkdir /mnt/ramdisk
//echo 'tmpfs /mnt/ramdisk tmpfs nodev,nosuid,size=20M 0 0' | sudo tee --append /etc/fstab
//sudo mount -a
//echo '[Unit]' | sudo tee --append /etc/systemd/system/safeshutdown.service
//echo 'Description=safeshutdown' | sudo tee --append /etc/systemd/system/safeshutdown.service
//echo '' | sudo tee --append /etc/systemd/system/safeshutdown.service
//echo '[Service]' | sudo tee --append /etc/systemd/system/safeshutdown.service
//echo 'ExecStart=/usr/bin/python3 /home/safeshutdown.py' | sudo tee --append /etc/systemd/system/safeshutdown.service
//echo '' | sudo tee --append /etc/systemd/system/safeshutdown.service
//echo '[Install]' | sudo tee --append /etc/systemd/system/safeshutdown.service
//echo 'WantedBy=multi-user.target' | sudo tee --append /etc/systemd/system/safeshutdown.service
//sudo curl -o "/home/safeshutdown.py" "https://raw.githubusercontent.com/eddwatts/quicksetup/main/safesuntdown.py?id=$RANDOM" -L
//sudo systemctl start safeshutdown    # Runs the script now
//sudo systemctl enable safeshutdown   # Sets the script to run every boot

//sudo sed -i 's/console=tty1/console=tty3 loglevel=3 logo.nologo/' /boot/cmdline.txt
//sudo sed -i -e "s/BOOT_UART=0/BOOT_UART=1/" /boot/bootcode.bin
//sudo sed -i 's/#hdmi_force_hotplug=1/hdmi_force_hotplug=1/' /boot/config.txt
//echo 'disable_splash=1' | sudo tee --append /boot/config.txt
//crontab -l >> mycron
//echo "00 05 * * * sudo reboot"' | tee --append mycron
//crontab mycron
//rm mycron

sudo sed -ri 's/^Port 22/Port 221234/g' /etc/ssh/sshd_config
//dell server
//sudo sed -i -e 's/$/ smsc95xx.macaddr=4c:d9:8f:5c:9f:c4/' /boot/cmdline.txt
//Synology NAS
//sudo sed -i -e 's/$/ smsc95xx.macaddr=00:11:32:B3:4D:F5/' /boot/cmdline.txt

//sudo reboot

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install git build-essential libssl-dev libffi-dev python-dev samba samba-common-bin cups python3-pip msmtp msmtp-mta unattended-upgrades apt-listchanges apticron -y
sudo pip3 install scapy pcapy
echo '# Default values for all accounts' | sudo tee --append /etc/msmtprc
echo 'defaults' | sudo tee --append /etc/msmtprc
echo 'auth on' | sudo tee --append /etc/msmtprc
echo 'tls on' | sudo tee --append /etc/msmtprc
echo '' | sudo tee --append /etc/msmtprc
echo '# Gmail' | sudo tee --append /etc/msmtprc
echo 'account gmail' | sudo tee --append /etc/msmtprc
echo 'host smtp.gmail.com' | sudo tee --append /etc/msmtprc
echo 'port 587' | sudo tee --append /etc/msmtprc
echo 'from $emailfrom' | sudo tee --append /etc/msmtprc
echo 'user $emailuser' | sudo tee --append /etc/msmtprc
echo 'password $emailpass' | sudo tee --append /etc/msmtprc
echo '' | sudo tee --append /etc/msmtprc
echo '# Syslog logging with facility LOG_MAIL instead of the default LOG_USER.' | sudo tee --append /etc/msmtprc
echo 'syslog LOG_MAIL' | sudo tee --append /etc/msmtprc
echo '' | sudo tee --append /etc/msmtprc
echo '# Set a default account' | sudo tee --append /etc/msmtprc
echo 'account default : gmail' | sudo tee --append /etc/msmtprc
chmod 600 /etc/msmtprc

sudo curl -o "/etc/apt/apt.conf.d/" https://gitlab.com/cgoff/raspberry-pi-hardening/-/raw/master/unattended-upgrades-config/50unattended-upgrades?inline=false -L
echo 'APT::Periodic::Enable "1";' | sudo tee --append /etc/apt/apt.conf.d/02periodic
echo 'APT::Periodic::Update-Package-Lists "1";' | sudo tee --append /etc/apt/apt.conf.d/02periodic
echo 'APT::Periodic::Download-Upgradeable-Packages "1";' | sudo tee --append /etc/apt/apt.conf.d/02periodic
echo 'APT::Periodic::Unattended-Upgrade "1";' | sudo tee --append /etc/apt/apt.conf.d/02periodic
echo 'APT::Periodic::AutocleanInterval "1";' | sudo tee --append /etc/apt/apt.conf.d/02periodic
echo 'APT::Periodic::Verbose "2";' | sudo tee --append /etc/apt/apt.conf.d/02periodic

sudo mkdir /home/backups
sudo touch /home/backups/testing.txt
sudo touch /var/log/samba-audit.log
sudo chown syslog:adm /var/log/samba-audit.log
echo 'local7.* /var/log/samba-audit.log' | sudo tee --append /etc/rsyslog.conf
sudo systemctl restart rsyslog
sudo systemctl restart syslog

echo '[global]' | sudo tee --append /etc/samba/smb.conf
echo 'workgroup = OFFICVLAN' | sudo tee --append /etc/samba/smb.conf
echo 'server string = Synology Backup' | sudo tee --append /etc/samba/smb.conf
echo 'netbios name = SYNOLOGY' | sudo tee --append /etc/samba/smb.conf
echo 'dns proxy = no' | sudo tee --append /etc/samba/smb.conf
echo 'log file = /var/log/samba/log.all' | sudo tee --append /etc/samba/smb.conf
echo 'log level = 0' | sudo tee --append /etc/samba/smb.conf
echo 'vfs object = full_audit' | sudo tee --append /etc/samba/smb.conf
echo 'full_audit:prefix = %U|%I|%i|%m|%S|%L|%R|%a|%T|%D' | sudo tee --append /etc/samba/smb.conf
echo 'full_audit:success = pread' | sudo tee --append /etc/samba/smb.conf
echo 'full_audit:failure = none' | sudo tee --append /etc/samba/smb.conf
echo 'full_audit:facility = local7' | sudo tee --append /etc/samba/smb.conf
echo 'full_audit:priority = notice' | sudo tee --append /etc/samba/smb.conf
echo 'max log size = 100' | sudo tee --append /etc/samba/smb.conf
echo 'panic action = /usr/share/samba/panic-action %d' | sudo tee --append /etc/samba/smb.conf
echo '#samba 4' | sudo tee --append /etc/samba/smb.conf
echo 'server role = standalone server' | sudo tee --append /etc/samba/smb.conf
echo '#samba 3' | sudo tee --append /etc/samba/smb.conf
echo '#security = user' | sudo tee --append /etc/samba/smb.conf
echo 'passdb backend = tdbsam' | sudo tee --append /etc/samba/smb.conf
echo 'obey pam restrictions = yes' | sudo tee --append /etc/samba/smb.conf
echo 'unix password sync = no' | sudo tee --append /etc/samba/smb.conf
echo 'map to guest = bad user' | sudo tee --append /etc/samba/smb.conf
echo 'usershare allow guests = yes' | sudo tee --append /etc/samba/smb.conf
echo '[backups]' | sudo tee --append /etc/samba/smb.conf
echo 'comment = Local Backup' | sudo tee --append /etc/samba/smb.conf
echo 'path = /home/backups' | sudo tee --append /etc/samba/smb.conf
echo 'guest ok = yes' | sudo tee --append /etc/samba/smb.conf
echo 'read only = yes' | sudo tee --append /etc/samba/smb.conf
git clone https://github.com/thinkst/opencanary
cd opencanary
sudo python3 setup.py install
echo '[Unit]' | sudo tee --append /etc/systemd/system/opencanary.service
echo 'Description=OpenCanary' | sudo tee --append /etc/systemd/system/opencanary.service
echo 'After=syslog.target' | sudo tee --append /etc/systemd/system/opencanary.service
echo 'After=network.target' | sudo tee --append /etc/systemd/system/opencanary.service
echo '' | sudo tee --append /etc/systemd/system/opencanary.service
echo '[Service]' | sudo tee --append /etc/systemd/system/opencanary.service
echo 'User=root' | sudo tee --append /etc/systemd/system/opencanary.service
echo 'Restart=always' | sudo tee --append /etc/systemd/system/opencanary.service
echo 'WorkingDirectory=/home/pi/opencanary' | sudo tee --append /etc/systemd/system/opencanary.service
echo 'ExecStart=/home/pi/opencanary/bin/opencanaryd --dev' | sudo tee --append /etc/systemd/system/opencanary.service
echo '' | sudo tee --append /etc/systemd/system/opencanary.service
echo '[Install]' | sudo tee --append /etc/systemd/system/opencanary.service
echo 'WantedBy=multi-user.target' | sudo tee --append /etc/systemd/system/opencanary.service
sudo systemctl enable opencanary.service
sudo systemctl start opencanary.service
sudo unattended-upgrade -d --dry-run

sudo apt install -y ufw
echo '-A ufw-before-input -p icmp --icmp-type echo-request -j ACCEPT' | sudo tee --append /etc/ufw/before.rules
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow Samba
sudo ufw allow 9418
sudo ufw allow 21
sudo ufw allow 3306
sudo ufw allow 22
sudo ufw allow 6379
sudo ufw allow 2289
sudo ufw allow 5060
sudo ufw allow 161
sudo ufw allow 123
sudo ufw allow 69
sudo ufw allow 8001
sudo ufw allow 23
sudo ufw allow 1433
sudo ufw allow 5000
sudo ufw allow 221234
sudo ufw reload
sudo ufw enable
sudo ufw status
sudo sed -i 's/"portscan.enabled": false/"portscan.enabled": true/' /etc/opencanary/opencanary.conf
sudo sed -i 's/"smb.enabled": false/"smb.enabled": true/' /etc/opencanary/opencanary.conf
sudo sed -i 's/"mysql.enabled": false/"mysql.enabled": true/' /etc/opencanary/opencanary.conf
sudo sed -i 's/"ssh.enabled": false/"ssh.enabled": true/' /etc/opencanary/opencanary.conf
sudo sed -i 's/"redis.enabled": false/"redis.enabled": true/' /etc/opencanary/opencanary.conf
sudo sed -i 's/"httpproxy.enabled" : false/"httpproxy.enabled" : true/' /etc/opencanary/opencanary.conf
sudo sed -i 's/"git.enabled": false/"git.enabled": true/' /etc/opencanary/opencanary.conf
sudo sed -i 's/"ftp.enabled": false/"ftp.enabled": true/' /etc/opencanary/opencanary.conf
sudo sed -i 's/"http.enabled": false/"http.enabled": true/' /etc/opencanary/opencanary.conf
sudo sed -i 's/"sip.enabled": false/"sip.enabled": true/' /etc/opencanary/opencanary.conf
sudo sed -i 's/"snmp.enabled": false/"snmp.enabled": true/' /etc/opencanary/opencanary.conf
sudo sed -i 's/"ntp.enabled": false/"ntp.enabled": true/' /etc/opencanary/opencanary.conf
sudo sed -i 's/"tftp.enabled": false/"tftp.enabled": true/' /etc/opencanary/opencanary.conf
sudo sed -i 's/"telnet.enabled": false/"telnet.enabled": true/' /etc/opencanary/opencanary.conf
sudo sed -i 's/"mssql.enabled": false/"mssql.enabled": true/' /etc/opencanary/opencanary.conf
sudo sed -i 's/"vnc.enabled": false/"vnc.enabled": true/' /etc/opencanary/opencanary.conf
echo '    "logger": {' | sudo tee --append /etc/opencanary/opencanary.conf
echo '    "class" : "PyLogger",' | sudo tee --append /etc/opencanary/opencanary.conf
echo '    "kwargs" : {' | sudo tee --append /etc/opencanary/opencanary.conf
echo '        "handlers": {' | sudo tee --append /etc/opencanary/opencanary.conf
echo '            "SMTP": {' | sudo tee --append /etc/opencanary/opencanary.conf
echo '                "class": "logging.handlers.SMTPHandler",' | sudo tee --append /etc/opencanary/opencanary.conf
echo '                "mailhost": ["smtp.gmail.com", 587],' | sudo tee --append /etc/opencanary/opencanary.conf
echo '                "fromaddr": "$emailfrom",' | sudo tee --append /etc/opencanary/opencanary.conf
echo '                "toaddrs" : ["$emailalert"],' | sudo tee --append /etc/opencanary/opencanary.conf
echo '                "subject" : "OpenCanary Alert",' | sudo tee --append /etc/opencanary/opencanary.conf
echo '                "credentials" : ["$emailuser", "$emailpass"],' | sudo tee --append /etc/opencanary/opencanary.conf
echo '                "secure" : []' | sudo tee --append /etc/opencanary/opencanary.conf
echo '             }' | sudo tee --append /etc/opencanary/opencanary.conf
echo '         }' | sudo tee --append /etc/opencanary/opencanary.conf
echo '     }' | sudo tee --append /etc/opencanary/opencanary.conf
echo ' }' | sudo tee --append /etc/opencanary/opencanary.conf

chostname=$(cat /etc/hostname)
//sudo raspi-config nonint do_hostname $hostname
sudo sed -i "s/$chostname/$hostname/g" /etc/hostname
sudo sed -i "s/$chostname/$hostname/g" /etc/hosts


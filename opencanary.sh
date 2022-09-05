//https://github.com/thinkst/opencanary
//https://www.youtube.com/watch?v=RanpEQBvAY0
//https://bobmckay.com/i-t-support-networking/hardware/create-a-security-honey-pot-with-opencanary-and-a-raspberry-pi-3-updated-2021/

sudo raspi-config nonint do_ssh 0
sudo raspi-config nonint do_i2c 0
sudo raspi-config nonint do_boot_wait 0
sudo raspi-config nonint do_configure_keyboard gb
sudo raspi-config nonint do_change_timezone Eurpoe/London
sudo raspi-config nonint do_change_locale en_GB.UTF-8
sudo raspi-config nonint do_gldriver G2
sudo raspi-config nonint do_glamor 0
echo 'dtoverlay=pi3-disable-wifi' | sudo tee --append /boot/config.txt
echo 'dtoverlay=pi3-disable-bt' | sudo tee --append /boot/config.txt
echo 'RuntimeWatchdogSec=14' | sudo tee --append /etc/systemd/system.conf
echo 'ShutdownWatchdogSec=2min' | sudo tee --append /etc/systemd/system.conf
sudo mkdir /mnt/ramdisk
echo 'tmpfs /mnt/ramdisk tmpfs nodev,nosuid,size=20M 0 0' | sudo tee --append /etc/fstab
sudo mount -a
echo '[Unit]' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo 'Description=safeshutdown' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo '' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo '[Service]' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo 'ExecStart=/usr/bin/python3 /home/safeshutdown.py' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo '' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo '[Install]' | sudo tee --append /etc/systemd/system/safeshutdown.service
echo 'WantedBy=multi-user.target' | sudo tee --append /etc/systemd/system/safeshutdown.service
sudo curl -o "/home/safeshutdown.py" "https://raw.githubusercontent.com/eddwatts/quicksetup/main/safesuntdown.py?id=$RANDOM" -L
sudo systemctl start safeshutdown    # Runs the script now
sudo systemctl enable safeshutdown   # Sets the script to run every boot

chostname=$(cat /etc/hostname)
sudo sed -i "s/$chostname/BOWSER/g" /etc/hostname
sudo sed -i "s/$chostname/BOWSER/g" /etc/hosts
sudo sed -ri 's/^Port 22/Port 221234/g' /etc/ssh/sshd_config
//dell server
sudo sed -i -e 's/$/ smsc95xx.macaddr=4c:d9:8f:5c:9f:c4/' /boot/cmdline.txt
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
echo 'from username@stmichaelsschool.co.uk' | sudo tee --append /etc/msmtprc
echo 'user username@stmichaelsschool.co.uk' | sudo tee --append /etc/msmtprc
echo 'password **your password**' | sudo tee --append /etc/msmtprc
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

//https://github.com/thinkst/opencanary
//https://www.youtube.com/watch?v=RanpEQBvAY0
//https://bobmckay.com/i-t-support-networking/hardware/create-a-security-honey-pot-with-opencanary-and-a-raspberry-pi-3-updated-2021/


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
sudo apt-get install git build-essential libssl-dev libffi-dev python-dev samba samba-common-bin cups python3-pip -y
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
sudo pip3 install scapy pcapy
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

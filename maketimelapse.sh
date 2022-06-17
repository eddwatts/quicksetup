echo '[Unit]' | sudo tee --append /etc/systemd/system/timelapse.service
echo 'Description=Timelapse script' | sudo tee --append /etc/systemd/system/timelapse.service
echo 'After=network-online.target' | sudo tee --append /etc/systemd/system/timelapse.service
echo 'Wants=network-online.target' | sudo tee --append /etc/systemd/system/timelapse.service
echo '' | sudo tee --append /etc/systemd/system/timelapse.service
echo '[Service]' | sudo tee --append /etc/systemd/system/timelapse.service
echo 'ExecStart=/usr/bin/python3 /home/timelapse.py' | sudo tee --append /etc/systemd/system/timelapse.service
echo '' | sudo tee --append /etc/systemd/system/timelapse.service
echo '[Install]' | sudo tee --append /etc/systemd/system/timelapse.service
echo 'WantedBy=multi-user.target' | sudo tee --append /etc/systemd/system/timelapse.service
sudo curl -o "/home/timelapse.py" "https://raw.githubusercontent.com/eddwatts/quicksetup/main/timelapse.py?id=$RANDOM" -L
sudo systemctl start timelapse    # Runs the script now
sudo systemctl enable timelapse   # Sets the script to run every boot

echo "install adbd"

sudo mkdir -p /data
sudo cp -frp adbd /data/
sudo cp adbd.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable ctrl-key
sudo systemctl start ctrl-key

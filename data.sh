#! /bin/bash
sudo apt update
sudo apt install -y nginx wget
sudo systemctl start nginx
sudo systemctl enable nginx
wget https://github.com/pepoangel/terrapri/blob/main/data.sh
#sudo mv /tmp/index.html /var/www/html/
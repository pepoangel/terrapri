#! /bin/bash
sudo apt-get update
sudo apt-get install -y niginx wget
sudo systemctl start nginx
sudo systemctl enable nginx
wget https://github.com/pepoangel/terrapri/blob/main/data.sh
#sudo mv /tmp/index.html /var/www/html/
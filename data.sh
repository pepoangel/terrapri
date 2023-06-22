#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2 wget
sudo systemctl start apache2
sudo systemctl enable apache2
sudo wget -O /tmp/index.html https://github.com/pepoangel/terrapri/blob/main/index.html
sudo mv /tmp/index.html /var/www/html/
#! /bin/bash
sudo apt update
sudo apt install -y nginx
sudo rm /var/www/html/index.nginx-debian.html
sudo cp index.html /var/www/html/
sudo systemctl start nginx
sudo systemctl enable nginx

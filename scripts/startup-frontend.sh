#!/bin/bash

apt-get update
apt-get install -y nginx
echo "Welcome to the Frontend Tier - ${hostname}" > /var/www/html/index.html
systemctl enable nginx
systemctl start nginx
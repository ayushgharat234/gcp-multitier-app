#!/bin/bash

apt-get update
apt-get install -y apache2
echo "DB Tier is up" > var/www/html/index.html
systemctl enable apache2
systemctl start apache2

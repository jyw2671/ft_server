#!/bin/bash

# setup index.html
if [ "$1" == "autoindex" ]; then
	sed -i "s/autoindex off;/autoindex on;/g" /etc/nginx/sites-available/default
	mv /var/www/html/index.html /var/www/html/index.nginx-debian.html 
else
	sed -i "s/autoindex on;/autoindex off;/g" /etc/nginx/sites-available/default
	mv /var/www/html/index.nginx-debian.html /var/www/html/index.html
fi

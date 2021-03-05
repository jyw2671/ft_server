#!/bin/bash

/bin/bash -C /autoindex.sh $1

service mysql start
service php7.3-fpm start
service nginx start

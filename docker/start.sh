#!/bin/bash
set -u

#
# Set user/password for Node Manager 
#
RPCUSER=$(grep rpcuser ${CONFIG_PATH}/bitcloud.conf | cut -f2- -d "=")
sed -i "s#RPCUSER#${RPCUSER}#g" /var/www/html/btdx/src/Config.php
RPCPASSWORD=$(grep rpcpassword ${CONFIG_PATH}/bitcloud.conf | cut -f2- -d "=")
sed -i "s#RPCPASSWORD#${RPCPASSWORD}#g" /var/www/html/btdx/src/Config.php
sed -i "s#RPCIP#${RPCIP}#g" /var/www/html/btdx/src/Config.php

#
# Start apache2
#
sed -i "s/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/btdx/g" /etc/apache2/sites-available/000-default.conf
service apache2 stop 

#
# Starting Bitcloud Service
#
# Hint: docker not supported systemd, use of supervisord
printf "*** Starting Bitcloud Node Manager ***\n"
exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf

#!/bin/bash
set -u

#
# Set user/password for Node Manager 
#
sed -i "s/RPCUSER/ /g" /var/www/html/btdx/src/Config.php
sed -i "s/RPCPASSWORD/ /g" /var/www/html/btdx/src/Config.php


#
# Start apache2
#
sed -i "s/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/btdx/g" /etc/apache2/sites-available/000-default.conf
service apache2 restart

#
# Starting Bitcloud Service
#
# Hint: docker not supported systemd, use of supervisord
printf "*** Starting Bitcloud Service ***\n"
exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf

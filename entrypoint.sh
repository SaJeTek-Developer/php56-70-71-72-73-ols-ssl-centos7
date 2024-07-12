#!/bin/bash

#set DEFAULT_PHP
sed -i -E "s/DEFAULT_PHP/$DEFAULT_PHP/g" /usr/local/lsws/conf/httpd_config.conf
sed -i -E "s/lsphp[0-9][0-9]/lsphp$DEFAULT_PHP/g" /usr/local/lsws/conf/httpd_config.conf

sed -i -E "s|VH_ROOT/html.*|VH_ROOT/html$DOCUMENT_ROOT|g" /usr/local/lsws/conf/vhosts/Example/vhconf.conf
	
# Start OpenLiteSpeed
/usr/local/lsws/bin/lswsctrl start

# Keep container running by tailing logs (or another long-running command)
tail -f /usr/local/lsws/logs/error.log

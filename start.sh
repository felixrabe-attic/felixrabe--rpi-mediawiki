#!/bin/bash

echo "Args: $@"

apache2ctl start
/etc/init.d/mysql start
echo
echo 'Open http://<ip_of_raspberry_pi>/mediawiki/ in your browser.'
while true ; do sleep 10 ; done

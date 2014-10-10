#!/bin/bash

set -e
echo "Args: $@"

apache2ctl start
/etc/init.d/mysql start
mysql -u root -B <<<'create database if not exists my_wiki;'
php /var/lib/mediawiki/maintenance/update.php --quick
echo
echo 'Open http://<ip_of_raspberry_pi>/mediawiki/ in your browser.'
while true ; do sleep 10 ; done

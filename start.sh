#!/bin/bash

set -e
echo "Args: $@"

apache2ctl start
/etc/init.d/mysql start
mysql -u root -B <<'EOT'
create database if not exists my_wiki;
grant index, create, select, insert, update, delete, alter, lock tables on my_wiki.* to 'wikiuser'@'localhost' identified by 'wupasswd';
EOT

if [[ $1 = setup ]] ; then
  echo 'Just did enough for you to run the setup.'
  echo 'Open http://<ip_of_raspberry_pi>/mediawiki/ in your browser and configure.'
  echo 'Then save LocalSettings.php, and export the MySQL database using:'
  echo '  mysqldump --user=wikiuser --password=wupasswd my_wiki > /var/www/bootstrap.sql'
  echo 'Get the file out using http://<ip_of_raspberry_pi>/bootstrap.sql'
  exit 0
fi

gunzip -c /bootstrap.sql.gz | mysql -u root -B

echo
echo 'Open http://<ip_of_raspberry_pi>/mediawiki/ in your browser.'
while true ; do sleep 10 ; done

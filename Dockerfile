# Naive approach,
# following http://trevorappleton.blogspot.ch/2013/04/installing-mediawiki-on-raspberry-pi.html

FROM sdhibit/rpi-raspbian

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mediawiki
RUN sed -i -e 's:^#Alias /mediawiki /var/lib/mediawiki:Alias /mediawiki /var/lib/mediawiki:g' /etc/mediawiki/apache.conf
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php-apc imagemagick

ADD LocalSettings.php /var/lib/mediawiki/LocalSettings.php
ADD start.sh /start.sh
EXPOSE 80

CMD ["/start.sh"]

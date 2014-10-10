# Naive approach,
# following http://trevorappleton.blogspot.ch/2013/04/installing-mediawiki-on-raspberry-pi.html

# FROM sdhibit/rpi-raspbian
FROM resin/rpi-raspbian

RUN apt-get update && apt-get install -y \
        imagemagick \
        mediawiki \
        php-apc \
    && rm -rf /var/lib/apt/lists/*

# Just host the wiki under /mediawiki:
RUN sed -i -e 's:^#Alias /mediawiki /var/lib/mediawiki:Alias /mediawiki /var/lib/mediawiki:g' /etc/mediawiki/apache.conf

# Tools I usually use to debug the image:
# RUN apt-get update && apt-get install -y \
#         less \
#         nano \
#     && rm -rf /var/lib/apt/lists/*

ADD LocalSettings.php /etc/mediawiki/LocalSettings.php
ADD start.sh /start.sh
ADD bootstrap.sql.gz /bootstrap.sql.gz
EXPOSE 80

CMD ["/start.sh"]

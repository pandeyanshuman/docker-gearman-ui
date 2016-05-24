FROM php:5.6-apache

RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/

RUN mkdir -p /usr/local/bin && php -r "readfile('https://getcomposer.org/installer');" | php \
    && mv composer.phar /usr/local/bin/composer

COPY php.ini.local /usr/local/etc/php/php.ini

RUN apt-get update && apt-get install -y unzip curl git

RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - \
    && apt-get install -y nodejs \
    && apt-get install -y build-essential

RUN npm install -g bower

RUN curl -L https://github.com/gaspaio/gearmanui/archive/master.zip -o /tmp/gearmanui.zip \
    && unzip -uo /tmp/gearmanui.zip -d /tmp/gearmanui \
    && mv /tmp/gearmanui/gearmanui-master /gearmanui \
    && rm -Rf /tmp/gearmanui.zip /tmp/gearmanui \
    && rm -Rf /var/www/html \
    && ln -s /gearmanui/web /var/www/html

WORKDIR /gearmanui

RUN sed -i s/'"symfony\/twig-bridge": "~2.7",'/'"symfony\/twig-bridge": "~2.7",\n        "symfony\/symfony": "2.7.*",'/ composer.json

RUN composer install --no-dev \
    && bower --allow-root install

COPY run_gearmanui.sh /

COPY gearmanui.yml /gearmanui/app/config/

RUN ln -s /gearmanui/app/config/gearmanui.yml /gearmanui/config.yml \
    && ln -s /gearmanui/vendor /gearmanui/web/vendor

VOLUME /gearmanui/app/config

EXPOSE 80

CMD ["/run_gearmanui.sh"]

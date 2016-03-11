FROM php:5.6.18-apache

RUN apt-get update && apt-get install -y vim libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev libicu-dev mlocate python pkg-config build-essential libmemcached-dev

RUN docker-php-ext-install iconv mcrypt mysqli
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install zip
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install intl

RUN a2enmod rewrite && apachectl restart

RUN touch /usr/local/etc/php/conf.d/xdebug.ini; \
	echo xdebug.remote_enable=1 >> /usr/local/etc/php/conf.d/xdebug.ini; \
  	echo xdebug.remote_autostart=0 >> /usr/local/etc/php/conf.d/xdebug.ini; \
  	echo xdebug.remote_connect_back=1 >> /usr/local/etc/php/conf.d/xdebug.ini; \
  	echo xdebug.remote_port=9000 >> /usr/local/etc/php/conf.d/xdebug.ini; \
  	echo xdebug.remote_log=/tmp/php5-xdebug.log >> /usr/local/etc/php/conf.d/xdebug.ini;

# Add user
RUN usermod -u 1000 www-data

# Install composer
#RUN curl -sS https://getcomposer.org/installer | php
#RUN mv composer.phar /usr/bin/composer

WORKDIR /var/www/html
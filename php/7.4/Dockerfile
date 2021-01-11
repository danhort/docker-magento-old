FROM adhocore/phpfpm:7.4 as magento_php

RUN apk --update add --no-cache --virtual .php-ext-install-deps \
        $PHPIZE_DEPS \
        # xsl deps
        libxslt-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libjpeg-turbo \
        jpeg-dev \
        ssmtp \
        patch

RUN docker-php-ext-configure gd --with-freetype --with-jpeg

RUN docker-php-ext-install -j$(nproc) xsl gd

RUN docker-php-ext-disable xdebug pcov psr phalcon

RUN perl -pi -e "s/mailhub=mail/mailhub=maildev/" /etc/ssmtp/ssmtp.conf

## Install Composer globally
RUN rm /usr/local/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer self-update --1
RUN composer config --global repos.packagist composer https://packagist.org 
RUN composer global require "hirak/prestissimo" "mage2tv/magento-cache-clean" --no-plugins --no-suggest --optimize-autoloader --classmap-authoritative
ENV PATH "${PATH}:/root/.composer/vendor/bin"

# Install Magerun 2
RUN wget https://files.magerun.net/n98-magerun2.phar \
	&& chmod +x ./n98-magerun2.phar \
    && mv ./n98-magerun2.phar /usr/local/bin/n98

RUN chmod 777 -Rf /var/www /var/www/.* \
	&& chown -Rf www-data:www-data /var/www /var/www/.*

RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories
RUN apk --no-cache add shadow && usermod -u 1000 www-data

FROM magento_php as magento_php_xdebug

# Install xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug
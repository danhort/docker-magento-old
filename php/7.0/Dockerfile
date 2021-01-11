FROM php:7.0-fpm-alpine as magento_php

# Install Magento requirements
RUN \
    apk add --no-cache --virtual .persistent-deps \
        freetype-dev \
        git \
        icu-libs \
        libjpeg-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libxml2-dev \
        libxml2-utils \
        libxslt-dev \
        openssh-client \
        patch \
        perl \
        nodejs \
        ssmtp && \
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        icu-dev && \
    docker-php-ext-configure bcmath && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) \
        bcmath \
        intl \
        gd \
        opcache \
        pdo_mysql \
        mysqli \
        soap \
        xsl \
        mcrypt \
        zip && \
    yes "" | pecl install apcu redis && \
    docker-php-ext-enable apcu redis && \
    perl -pi -e "s/mailhub=mail/mailhub=maildev/" /etc/ssmtp/ssmtp.conf && \
    perl -pi -e "s|;pm.status_path = /status|pm.status_path = /php_fpm_status|g" /usr/local/etc/php-fpm.d/www.conf && \
    apk del .build-deps

## Install Composer globally
RUN rm /usr/local/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer self-update --1
RUN composer config --global repos.packagist composer https://packagist.org 
RUN composer global require "hirak/prestissimo" "mage2tv/magento-cache-clean" --no-plugins --no-suggest --optimize-autoloader --classmap-authoritative
ENV PATH "${PATH}:/root/.composer/vendor/bin"

# Install Magerun 2
# Magerun >= v2.4 does not support PHP <= 7.1
RUN wget https://files.magerun.net/n98-magerun2-3.2.0.phar \
	&& chmod +x ./n98-magerun2-3.2.0.phar \
    && mv ./n98-magerun2-3.2.0.phar /usr/local/bin/n98

RUN chmod 777 -Rf /var/www /var/www/.* \
	&& chown -Rf www-data:www-data /var/www /var/www/.* \
	&& echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories \
    && apk --no-cache add shadow && usermod -u 1000 www-data

FROM magento_php as magento_php_xdebug

# Install xdebug
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS && \
    yes "" | pecl install xdebug-2.6.0 && \
    docker-php-ext-enable xdebug

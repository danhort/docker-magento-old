FROM php:7.2-fpm-alpine

# Install Magento requirements
RUN \
    apk add --no-cache \
        autoconf \
        automake \
        freetype-dev \
        g++ \
        git \
        icu-dev \
        icu-libs \
        libjpeg-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libxml2-dev \
        libxml2-utils \
        libxslt-dev \
        libwebp-dev \
        make \
	nodejs \
	npm \
        openssh-client \
        patch \
        perl \
        shadow \
        ssmtp \
        yarn && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS && \
    docker-php-ext-configure bcmath && \
    docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-webp-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) \
        bcmath \
        intl \
        gd \
        opcache \
        pdo_mysql \
        soap \
        xsl \
        sockets \
        zip && \
    yes "" | pecl install apcu redis && \
    docker-php-ext-enable apcu redis && \
    perl -pi -e "s/mailhub=mail/mailhub=maildev/" /etc/ssmtp/ssmtp.conf && \
    perl -pi -e "s|;pm.status_path = /status|pm.status_path = /php_fpm_status|g" /usr/local/etc/php-fpm.d/www.conf && \
    yarn global add grunt-cli && \
    apk del .build-deps

## Install Composer globally
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require "hirak/prestissimo" "mage2tv/magento-cache-clean" \
    --no-suggest --optimize-autoloader --classmap-authoritative
ENV PATH "${PATH}:/root/.composer/vendor/bin"

# Install Magerun 2
RUN wget https://files.magerun.net/n98-magerun2.phar \
	&& chmod +x ./n98-magerun2.phar \
    && mv ./n98-magerun2.phar /usr/local/bin/n98

# Install & Setup Xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Set up FE deps
RUN npm install

RUN chmod 777 -Rf /var/www /var/www/.* \
	&& chown -Rf www-data:www-data /var/www /var/www/.* \
    && usermod -u 1000 www-data 

# fix work iconv library with alphine
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

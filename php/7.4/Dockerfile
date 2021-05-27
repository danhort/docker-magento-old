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
        patch \
        git

RUN docker-php-ext-configure gd --with-freetype --with-jpeg

RUN docker-php-ext-install -j$(nproc) xsl gd

RUN docker-php-ext-disable xdebug pcov psr phalcon

RUN perl -pi -e "s/mailhub=mail/mailhub=maildev/" /etc/ssmtp/ssmtp.conf

## Install Composer globally
RUN rm -f /usr/local/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH "${PATH}:/root/.composer/vendor/bin"

# Install Magerun 2
RUN wget https://files.magerun.net/n98-magerun2.phar \
	&& chmod +x ./n98-magerun2.phar \
    && mv ./n98-magerun2.phar /usr/local/bin/n98

RUN chmod 777 -Rf /var/www /var/www/.* \
	&& chown -Rf www-data:www-data /var/www /var/www/.*

RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories
RUN apk --no-cache add shadow && usermod -u 1000 www-data

FROM magento_php as magento_php_ioncube

# install ioncube :(
RUN cd /tmp \
	&& curl -o ioncube.tar.gz http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
    && tar -xvvzf ioncube.tar.gz \
    && mv ioncube/ioncube_loader_lin_7.4.so /usr/local/lib/php/extensions/ \
    && rm -Rf ioncube.tar.gz ioncube \
    && echo "zend_extension=/usr/local/lib/php/extensions/ioncube_loader_lin_7.4.so" > /usr/local/etc/php/conf.d/00_docker-php-ext-ioncube_loader_lin_7.4.ini

FROM magento_php as magento_php_xdebug

# Install xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug
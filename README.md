# Docker for Magento2
This repository allows the creation of a Docker environment that meets
[Magento 2](http://devdocs.magento.com/guides/v2.3/install-gde/system-requirements-tech.html) requirements.

## Services
* `elasticsearch`: [docker.elastic.co/elasticsearch/elasticsearch:5.2.2](https://github.com/danhort/docker-magento2/blob/master/elasticsearch/Dockerfile) custom image with some plugins (search engine).
* `maildev`: [djfarrelly/maildev:latest](https://hub.docker.com/r/djfarrelly/maildev/) image (emails debugging).
* `mysql`: [mysql:5.7](https://store.docker.com/images/mysql) image (Magento database).
* `nginx`: [nginx:1.15-alpine](https://github.com/danhort/docker-magento2/blob/master/nginx/Dockerfile) custom image with HTTPS (web server).
* `php` : 
    - [php:7.1-fpm-jessie](https://github.com/danhort/docker-magento2/tree/php/7.1/Dockerfile) custom image with additional extensions and Composer.
* `redis`: [redis:4-alpine](https://store.docker.com/images/redis) image (Magento session and caches).
* `phpmyadmin`: [phpmyadmin/phpmyadmin](https://github.com/danhort/docker-magento2/blob/master/phpmyadmin/Dockerfile) custom image.

## SetUp
In your project root dir.
```
./path/to/docker/init.sh
```
This creates a Makefile in the project root and docker.env and nginx.conf files in the development directory.  
Update the docker.env variables COMPOSE_PROJECT_NAME, MAGENTO_ROOT and if you wish to use a different version of php PHP_VERSION.

## Usage
```
make
```

## Links
Magento: https://www.magento.localhost  
Magento admin: https://www.magento.localhost/admin   
> user: admin   
> password: admin123  

Maildev: http://www.magento.localhost:1080  
phpMyAdmin: http://www.magento.localhost:8080  

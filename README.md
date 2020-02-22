# Docker for Magento 1 and Magento 2

## Services
* `elasticsearch`: [ptanov/elasticsearch-5.2-cgroups2](https://github.com/danhort/docker-magento2/blob/master/elasticsearch/Dockerfile) custom image with some plugins (search engine).
* `maildev`: [djfarrelly/maildev:latest](https://hub.docker.com/r/djfarrelly/maildev/) image (emails debugging).
* `mysql`: [mysql:5.7](https://store.docker.com/images/mysql) image (Magento database).
* `nginx`: [nginx:1.15-alpine](https://github.com/danhort/docker-magento2/blob/master/nginx/Dockerfile) custom image with HTTPS (web server).
* `php` : 
    - [php:5.6-fpm-alpine](https://github.com/danhort/docker-magento2/tree/php/5.6/Dockerfile) custom image with additional extensions and Composer.
    - [php:7.0-fpm-alpine](https://github.com/danhort/docker-magento2/tree/php/7.0/Dockerfile) custom image with additional extensions and Composer.
    - [php:7.1-fpm-jessie](https://github.com/danhort/docker-magento2/tree/php/7.1/Dockerfile) custom image with additional extensions and Composer.
    - [php:7.2-fpm-alpine](https://github.com/danhort/docker-magento2/tree/php/7.2/Dockerfile)
* `redis`: [redis:4-alpine](https://store.docker.com/images/redis) image (Magento session and caches).
* `phpmyadmin`: [phpmyadmin/phpmyadmin](https://github.com/danhort/docker-magento2/blob/master/phpmyadmin/Dockerfile) custom image.

## SetUp
In your project root dir.
```
wget https://raw.githubusercontent.com/danhort/docker-magento/master/init.sh
chmod +x init.sh
./init.sh
```
This creates a Makefile in the project root and docker.env file in the ops directory.  
Update the docker.env variables COMPOSE_PROJECT_NAME, MAGENTO_ROOT, PHP_VERSION, MAGENTO_VERSION.  
Create the source folder (MAGENTO_ROOT) in the project root where your code will live.

## Usage
```
make
```

## Links
Magento: https://magento.localhost  
Magento admin: https://magento.localhost/admin   
Maildev: http://localhost:1080  
phpMyAdmin: http://localhost:8080

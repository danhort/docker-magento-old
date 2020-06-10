 ```
    _____             _               __  __                        _        
   |  __ \           | |             |  \/  |                      | |       
   | |  | | ___   ___| | _____ _ __  | \  / | __ _  __ _  ___ _ __ | |_ ___  
   | |  | |/ _ \ / __| |/ / _ \ '__| | |\/| |/ _` |/ _` |/ _ \ '_ \| __/ _ \ 
   | |__| | (_) | (__|   <  __/ |    | |  | | (_| | (_| |  __/ | | | || (_) |
   |_____/ \___/ \___|_|\_\___|_|    |_|  |_|\__,_|\__, |\___|_| |_|\__\___/ 
                                                    __/ |                    
                                                   |___/                   
```
# Docker development environment for Magento 1 and Magento 2

## Services
* `elasticsearch`: [ptanov/elasticsearch-5.2-cgroups2](https://github.com/danhort/docker-magento2/blob/master/elasticsearch/Dockerfile)
* `maildev`: [djfarrelly/maildev:latest](https://hub.docker.com/r/djfarrelly/maildev/)
* `mysql`: [mysql:5.7](https://store.docker.com/images/mysql)
* `nginx`: [nginx:1.15-alpine](https://github.com/danhort/docker-magento2/blob/master/nginx/Dockerfile)
* `php` : 
    - [php:5.6-fpm-alpine](https://github.com/danhort/docker-magento2/blob/master/php/5.6/Dockerfile)
    - [php:7.0-fpm-alpine](https://github.com/danhort/docker-magento2/blob/master/php/7.0/Dockerfile)
    - [php:7.1-fpm-jessie](https://github.com/danhort/docker-magento2/blob/master/php/7.1/Dockerfile)
    - [php:7.2-fpm-alpine](https://github.com/danhort/docker-magento2/blob/master/php/7.2/Dockerfile)
    - [php:7.3-fpm-alpine](https://github.com/danhort/docker-magento2/blob/master/php/7.3/Dockerfile)
* `redis`: [redis:4-alpine](https://store.docker.com/images/redis)
* `varnish`: [varnish](https://hub.docker.com/_/varnish
* `phpmyadmin`: [phpmyadmin/phpmyadmin](https://github.com/danhort/docker-magento2/blob/master/phpmyadmin/Dockerfile)

## Setup
In your project root dir.
```
wget https://raw.githubusercontent.com/danhort/docker-magento/master/bin/init.sh
chmod +x init.sh
./init.sh
```
This creates a Makefile in the project root, a docker.env file and a custom-nginx.conf file in the ops directory.  
Update the docker.env variables COMPOSE_PROJECT_NAME, MAGENTO_ROOT, PHP_VERSION, MAGENTO_VERSION.   
Update the ops/custom-nginx.conf file with location directives you need. (e.g. blog/)   
Create the source folder (MAGENTO_ROOT) in the project root where your code will live.

## Install docker-magento tool (optional)
Install docker-magento binary to access the init script from everywhere.   
This will give you a bash tool to setup this environment using the command `docker-magento`
```
make install
```

## Usage
```
make
```

## Links
Magento: https://magento.localhost  
Magento admin: https://magento.localhost/admin   
Maildev: http://localhost:1080  
phpMyAdmin: http://localhost:8080

## Database credentials
host: mysql   
name: magento   
user: magento   
password: magento   

There is a Magento 2 env.php sample file in ops/samples

## Xdebug
To enable Xdebug you must change the `DOCKER_PHP_IMAGE` variable in ops/docker.env from `magento_php` to `magento_php_xdebug`.   
The port used for Xdebug is 9001.   
The following is a configuration sample for vscode: ops/samples/launch.json.sample

## Comments
*This environment setup has only been tested on linux.*

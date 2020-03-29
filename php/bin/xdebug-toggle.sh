#!/usr/bin/env sh

XDEBUG_ON_PATH=/usr/local/etc/php/conf.d/xdebug.ini
XDEBUG_OFF_PATH=/usr/local/etc/php/conf.d/xdebug.ini.off

if [ -d $XDEBUG_ON_PATH ]; then
    mv $XDEBUG_ON_PATH $XDEBUG_OFF_PATH
else
    mv $XDEBUG_OFF_PATH $XDEBUG_ON_PATH
fi

#!/bin/bash
supervisord -c /etc/supervisord.conf
supervisorctl start laravel-php-fpm:*
supervisorctl start laravel-nginx:*

tail -f /dev/null
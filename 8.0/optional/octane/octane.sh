#!/bin/bash

php /var/www/artisan octane:stop >/dev/null
rm -f /var/www/storage/framework/octane/octane-server-state.json /var/www/storage/logs/octane-server-state.json
php /var/www/artisan octane:start
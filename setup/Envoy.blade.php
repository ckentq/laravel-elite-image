@servers(['web' => '127.0.0.1'])

@task('production')
{{--基本設定--}}
php artisan storage:link
php artisan route:cache
php artisan view:cache
{{--啟動設定--}}
php -S 0.0.0.0:80 -t public
tail -f /dev/null
@endtask

@task('local')
{{--下載套件--}}
composer install
yarn --ignore-engines install &
{{--基本設定--}}
php artisan migrate
php artisan storage:link
{{--啟動設定--}}
supervisord -c /etc/supervisord.conf
supervisorctl start laravel-webpack:*
php -S 0.0.0.0:80 -t public

@endtask

@task('base')
php artisan storage:link
php artisan route:cache
php artisan view:cache
@endtask

@task('schedule')
php /var/www/artisan schedule:run >> /dev/null 2>&1;
@endtask

@task('worker')
php /var/www/artisan queue:work --sleep=3 --tries=3 --daemon
@endtask

@task('swoole')
php /var/www/artisan swoole:http restart
@endtask

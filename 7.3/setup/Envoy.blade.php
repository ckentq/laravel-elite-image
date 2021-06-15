@servers(['web' => '127.0.0.1'])

@task('production')
supervisord -c /etc/supervisord.conf
{{--基本設定--}}
php artisan storage:link
php artisan route:cache
php artisan view:cache
{{--啟動設定--}}
supervisorctl start laravel-php-fpm:*
supervisorctl start laravel-nginx:*

tail -f /dev/null
@endtask

@task('local')
supervisord -c /etc/supervisord.conf
{{--啟動設定--}}
supervisorctl start laravel-php-fpm:*
supervisorctl start laravel-nginx:*

tail -f /dev/null
@endtask

@task('laravel-setting')
php artisan migrate
php artisan storage:link
php artisan route:cache
php artisan view:cache
@endtask

@task('nginx')
supervisorctl start laravel-nginx:*
@endtask

@task('nginx-swoole')
supervisorctl start laravel-nginx-swoole:*
@endtask

@task('php-fpm')
supervisorctl start laravel-php-fpm:*
@endtask

@task('swoole')
supervisorctl start laravel-swoole:*
@endtask

@task('schedule')
php /var/www/artisan schedule:run >> /dev/null 2>&1;
@endtask

@task('worker')
supervisorctl start laravel-worker:*
@endtask
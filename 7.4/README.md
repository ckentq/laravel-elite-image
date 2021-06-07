# laravel-elite-image
> 精簡且可用於開發與生產環境的 PHP/Laravel Docker Image
###### tags: `Docker` `Laravel`

### Laravel Elite Image 是什麼？

這是一個針對開發與生產特別設計的 PHP/Laravel Docker 環境，使用 [Envoy 任務執行器](https://github.com/laravel/envoy) 設計啟動腳本，
可以很輕鬆的根據開發或生產需求來客製化啟動腳本，另外使用 [Supervisor 進程管理工具](http://supervisord.org/index.html) 管理進程，
提供 Nginx、PHP-FPM、PHP Server、PHP swoole、Laravel 排程、Laravel 佇列處理等常見的進程管理，可搭配
[laravel-swoole](https://github.com/swooletw/laravel-swoole) 使用高效能的 Swoole 網絡通信引擎。

### 快速啟動

1. 安裝設定檔

```bash
wget https://github.com/ckentq/laravel-elite-image/raw/{version}/7.4/setup/Dockerfile
wget https://github.com/ckentq/laravel-elite-image/raw/{version}/7.4/setup/Envoy.blade.php
wget https://github.com/ckentq/laravel-elite-image/raw/{version}/7.4/setup/docker-compose.yml.example
cp docker-compose.yml.example docker-compose.yml
```

2. 啟動環境(請先設定好.env)

```bash
docker-compose up -d
```

### 標籤對應的Dockerfile

* [latest-php8.0](https://github.com/LarvataTW/laravel-elite-image/blob/master/8.0/Dockerfile) (未來版本)
* [latest-php7.4](https://github.com/LarvataTW/laravel-elite-image/blob/master/7.4/Dockerfile) (主要維護版本)
* [latest-php7.3](https://github.com/LarvataTW/laravel-elite-image/blob/master/7.3/Dockerfile) (僅提供安全問題修復)
* [latest-php7.2](https://github.com/LarvataTW/laravel-elite-image/blob/master/7.2/Dockerfile) (已停止支援)
* [latest-php5.6](https://github.com/LarvataTW/laravel-elite-image/blob/master/5.6/Dockerfile) (已停止支援)

### Dockerfile 常用

#### Nginx

1. 下載Nginx設定檔 `wget https://github.com/ckentq/laravel-elite-image/raw/{version}/7.4/config/nginx.conf`

2. 設定dockerfile

```dockerfile
COPY nginx.conf /etc/nginx/nginx.conf
```

#### PHP

1. 下載PHP設定檔 `wget https://github.com/ckentq/laravel-elite-image/raw/{version}/7.4/config/php.ini`

2. 下載PHP-FPM設定檔 `wget https://github.com/ckentq/laravel-elite-image/raw/{version}/7.4/config/www.ini`

3. 設定dockerfile

```dockerfile
COPY www.conf /usr/local/etc/php-fpm.d/www.conf
COPY php.ini /usr/local/etc/php/conf.d/custom.ini
```

### `Envoy.blade.php` 啟動設定

#### 修改為 Nginx

```bash
supervisord -c /etc/supervisord.conf
supervisorctl start laravel-php-fpm:*
supervisorctl start laravel-nginx:*
```

#### 修改為 swoole

```bash
supervisord -c /etc/supervisord.conf
supervisorctl start laravel-swoole:*
```

#### 啟動排程

```bash
supervisord -c /etc/supervisord.conf
supervisorctl start laravel-schedule:*
```

#### 啟動佇列處理

```bash
supervisord -c /etc/supervisord.conf
supervisorctl start laravel-worker:*
```

### Supervisor 腳本

|腳本|說明|
|---|---|
|laravel-nginx|Nginx 服務|
|laravel-php-fpm|PHP-FPM 服務|
|laravel-server|PHP Server 服務|
|laravel-swoole|PHP swoole 服務|
|laravel-schedule|Laravel 排程|
|laravel-worker|Laravel 佇列處理|
|laravel-webpack|Webpack 熱更新(開發用)|

### 已安裝工具

|套件|說明|
|---|---|
|supervisor|進程管理工具|
|curl|Http命令列工具|
|vim|文件編輯工具|
|tar|檔案壓縮工具|
|nodejs|JavaScript 執行環境|
|yarn|JavaScript 管理工具|

### 已安裝 PHP 擴展

|擴展|用途|
|---|---|
|swoole|Swoole服務|
|redis|Redis連線|
|mcrypt|加密|
|iconv|中文字處理|
|mbstring|中文字處理|
|pdo|資料庫連線|
|pdo_mysql|Mysql連線|
|mysqli|Mysql連線|
|tokenizer|laravel tinker|
|xml|RSS、Excel...等功能|
|zip|檔案壓縮(gzip)|
|exif|讀取副檔名|

### 相關支援

* 維護者: [果子云數位科技](https://github.com/LarvataTW)

### 常見問題

Ｑ：環境變數未更改
Ａ：請重新起動

Ｑ：無法連上這個網站
Ａ：請確定已設定好**env**與 `composer install` 並 重新起動

Ｑ：No application encryption key has been specified.
Ａ：請設定APP Key `php artisan key:generate`
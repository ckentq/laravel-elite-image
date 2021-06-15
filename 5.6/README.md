# laravel-elite-image
###### tags: `Docker` `Laravel`

### 快速啟動

1. 安裝設定檔

```bash
wget https://github.com/LarvataTW/laravel-elite-image/raw/{version}/5.6/setup/Dockerfile
wget https://github.com/LarvataTW/laravel-elite-image/raw/{version}/5.6/setup/docker-compose.yml.example
cp docker-compose.yml.example docker-compose.yml
```

2. 啟動環境(請先設定好.env)

```bash
docker-compose up -d
```

### Dockerfile 常用

#### Nginx 

1. 下載Nginx設定檔 `wget https://github.com/LarvataTW/laravel-elite-image/raw/{version}/5.6/config/nginx.conf`

2. 設定dockerfile

```dockerfile
COPY nginx.conf /etc/nginx/nginx.conf
```

#### PHP

1. 下載PHP設定檔 `wget https://github.com/LarvataTW/laravel-elite-image/raw/{version}/5.6/config/php.ini`

2. 下載PHP-FPM設定檔 `wget https://github.com/LarvataTW/laravel-elite-image/raw/{version}/5.6/config/www.ini`

3. 設定dockerfile

```dockerfile
COPY www.conf /usr/local/etc/php-fpm.d/www.conf
COPY php.ini /usr/local/etc/php/conf.d/custom.ini
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
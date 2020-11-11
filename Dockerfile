FROM php:7.3-fpm-alpine

MAINTAINER Linc <qulamj@gmail.com>

ENV PHPIZE_DEPS \
        g++ \
        make \
        autoconf \
        re2c \
        imagemagick-dev \
        libmcrypt-dev \
        libpng-dev \
        curl-dev \
        libxml2-dev

# 安裝必要套件
RUN apk update \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && apk add --no-cache \
        imagemagick \
        libmcrypt \
        libpng \
        curl \
        libzip-dev \
        zip \
    && pecl install \
        imagick \
        swoole \
        redis \
        mcrypt-1.0.2 \
    && docker-php-ext-configure gd \
        --with-gd \
    && docker-php-ext-install \
        curl \
        iconv \
        mbstring \
        pdo \
        pdo_mysql \
        mysqli \
        pcntl \
        tokenizer \
        xml \
        zip \
        exif \
        gd \
    && docker-php-ext-enable \
        swoole \
        redis \
        mcrypt \
    && apk del -f .build-deps \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

# 安裝常用工具 && 安裝 composer && 修改 composer 鏡像為日本 && composer 加速工具 && php 任務執行器
RUN apk update \
    && apk add --no-cache supervisor nginx nodejs yarn vim bash tar \
    && curl -s https://getcomposer.org/installer | php -- --quiet --install-dir=/usr/bin --filename=composer --version=1.10.16 \
    && composer config -g repos.packagist composer https://packagist.jp \
    && composer global require "hirak/prestissimo" \
    && composer global require "laravel/envoy" \
    && chmod +x ~/.composer/vendor/bin/envoy && ln -s ~/.composer/vendor/bin/envoy /usr/bin/envoy \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && rm /etc/nginx/conf.d/default.conf \
    && rm -rf /var/www/*

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY config/php.ini /usr/local/etc/php/conf.d/custom.ini

# supervisord
COPY config/supervisord.conf /etc/supervisord.conf

COPY ./supervisord.d /etc/supervisord.d

WORKDIR /var/www

CMD [ "envoy", "run", "production"]

FROM php:7.2-fpm-alpine

MAINTAINER Linc <qulamj@gmail.com>

ENV PHPIZE_DEPS \
		autoconf \
		dpkg-dev dpkg \
		file \
		g++ \
		gcc \
		libc-dev \
		make \
		pkgconf \
		re2c

# 修改 apk 鏡像為阿里雲
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 安裝必要套件
RUN apk update \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        curl-dev \
        imagemagick-dev \
        libtool \
        libxml2-dev \
    && apk add --no-cache \
        curl \
        bash \
        binutils \
        tar \
        imagemagick \
        nodejs \
        yarn \
        libpng-dev \
	    libmcrypt-dev \
	    supervisor \
    && pecl install \
        imagick \
        swoole \
	    redis \
	    mcrypt-1.0.1 \
	    xdebug \
    && docker-php-ext-install \
        curl \
        iconv \
        mbstring \
        pdo \
        pdo_mysql \
        pcntl \
        tokenizer \
        xml \
        zip \
        exif \
    && docker-php-ext-enable \
        imagick \
        exif \
        swoole \
	    redis \
	    mcrypt \
    && curl -s https://getcomposer.org/installer | php -- --quiet --install-dir=/usr/bin --filename=composer \
    && apk del -f .build-deps \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

# 修改 composer 鏡像為日本
RUN composer config -g repos.packagist composer https://packagist.jp

# composer 加速工具
RUN composer global require "hirak/prestissimo"

# php 任務執行器
RUN composer global require "laravel/envoy"

RUN chmod +x ~/.composer/vendor/bin/envoy && ln -s ~/.composer/vendor/bin/envoy /usr/bin/envoy

# supervisord
COPY supervisord.conf /etc/supervisord.conf

COPY ./supervisord.d /etc/supervisord.d

WORKDIR /var/www

CMD [ "envoy", "run", "production"]
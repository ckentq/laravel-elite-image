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

# 安裝必要套件
RUN apk update \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        curl-dev \
        imagemagick-dev \
        libtool \
        libxml2-dev \
		freetype-dev \
		libpng-dev \
		libjpeg-turbo-dev\
	    libmcrypt-dev \
    && apk add --no-cache \
        vim \
        curl \
        bash \
        binutils \
        tar \
        imagemagick \
        nodejs \
        yarn \
		freetype \
        libpng \
		libjpeg-turbo \
        libmcrypt \
	    supervisor \
	    nginx \
	    openjdk8-jre \
    && pecl install \
        imagick \
        swoole \
	    redis \
	    mcrypt-1.0.1 \
	    xdebug \
	&& docker-php-ext-configure gd \
		--with-gd \
		--with-freetype-dir=/usr/include/ \
		--with-png-dir=/usr/include/ \
		--with-jpeg-dir=/usr/include/ \
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
        gd \
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

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf
# Remove default server definition
RUN rm /etc/nginx/conf.d/default.conf

# Configure PHP-FPM
COPY config/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY config/php.ini /usr/local/etc/php/conf.d/custom.ini

# supervisord
COPY config/supervisord.conf /etc/supervisord.conf

COPY ./supervisord.d /etc/supervisord.d

RUN rm -rf /var/www/*

WORKDIR /var/www

CMD [ "envoy", "run", "production"]
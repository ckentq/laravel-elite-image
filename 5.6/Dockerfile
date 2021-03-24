FROM php:5.6-fpm-alpine

MAINTAINER Linc <qulamj@gmail.com>

ENV PHPIZE_DEPS \
        g++ \
        make \
        autoconf \
        re2c \
        curl-dev \
        libxml2-dev \
        imagemagick-dev \
        libpng-dev

# 安裝必要套件 && 安裝常用工具
RUN apk update \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && apk add --no-cache \
    	libstdc++ \
    	vim \
    	bash \
    	supervisor \
    	nginx \
    	libzip-dev \
    	zip \
    	imagemagick \
    	freetype-dev \
    	libjpeg-turbo-dev \
    	libpng-dev \
    	icu-dev \
    	libmcrypt-dev \
    	libxml2-dev \
    	libxslt-dev \
    	&& docker-php-ext-install \
    	bcmath \
    	gd \
    	intl \
    	opcache \
    	pdo_mysql \
    	soap \
    	xsl \
    	curl \
    	iconv \
    	mbstring \
    	pdo \
    	pdo_mysql \
    	mysqli \
    	tokenizer \
    	xml \
    	zip \
    	exif \
    	mcrypt \
    && pecl install imagick \
    && docker-php-ext-configure gd \
    	--with-gd \
    && chmod -R 755 /usr/local/lib/php/extensions \
    && apk del -f .build-deps \
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

COPY config/start.sh /var/start.sh

WORKDIR /var/www

RUN chmod 755 /var/start.sh

CMD ["/var/start.sh"]
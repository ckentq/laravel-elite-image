FROM larvata/laravel-elite-image:latest

# # 圖片處理
# RUN apk update \
#     && apk add --no-cache --virtual .build-deps g++ make autoconf imagemagick-dev libpng-dev \
#     && apk add --no-cache imagemagick libpng \
#     && pecl install imagick \
#     && docker-php-ext-configure gd \
#         --with-gd \
#     && docker-php-ext-install gd \
#     && apk del -f .build-deps \
#     && rm -rf /var/cache/apk/* \
#     && rm -rf /tmp/*

# # JavaScript 處理
# RUN apk update \
#     && apk add --no-cache nodejs yarn \
#     && rm -rf /var/cache/apk/* \
#     && rm -rf /tmp/*

# Composer install
COPY composer.* /tmp/
RUN cd /tmp && composer install --no-dev --no-autoloader

# Yarn install
# COPY package.json yarn.* /tmp/
# RUN cd /tmp && yarn --ignore-engines install

# Copy project
COPY ./ /var/www

# Composer load && Yarn build
# RUN rm -rf /var/www/vendor && rm -rf /var/www/node_modules && mv /tmp/vendor/ /var/www && mv /tmp/node_modules/ /var/www && composer dump-autoload && yarn production

# Composer load
RUN rm -rf /var/www/vendor && mv /tmp/vendor/ /var/www && composer dump-autoload
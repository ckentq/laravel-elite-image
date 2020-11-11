FROM larvata/laravel-elite-image:latest

# Composer install
COPY composer.* /tmp/
RUN cd /tmp && composer install --no-dev --no-autoloader

# Yarn install
COPY package.json yarn.* /tmp/
RUN cd /tmp && yarn --ignore-engines install

# Copy project
COPY ./ /var/www

RUN rm -rf /var/www/vendor && rm -rf /var/www/node_modules && mv /tmp/vendor/ /var/www && mv /tmp/node_modules/ /var/www && composer dump-autoload && yarn production

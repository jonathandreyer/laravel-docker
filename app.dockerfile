FROM php:7.2-fpm-alpine

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer

COPY . /var/www
WORKDIR /var/www

RUN composer install --no-dev --no-interaction -o

RUN chown -R www-data:www-data \
        /var/www/storage \
        /var/www/bootstrap/cache

RUN php artisan key:generate
RUN php artisan optimize

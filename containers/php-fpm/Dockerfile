# ./php-fpm/Dockerfile
ARG PHP_VERSION=8.2
FROM php:${PHP_VERSION}-fpm-alpine

# Set working directory
WORKDIR /var/www/html

# Install essential PHP extensions for web development and database access
# pdo_pgsql for PostgreSQL, pdo_mysql for MariaDB/MySQL
# You might need others like: gd, intl, zip, bcmath, soap, etc.
# Add build dependencies, install extensions, then remove dependencies
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS postgresql-dev mariadb-dev \
    && docker-php-ext-install pdo pdo_pgsql pdo_mysql \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del .build-deps

# Install composer (Optional but common)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy custom php.ini settings
# These settings will be loaded *after* the main php.ini
COPY php.ini /usr/local/etc/php/conf.d/custom-php.ini

# Optional: Set permissions if needed, although mounting src often handles this
# RUN chown -R www-data:www-data /var/www/html

# Expose port 9000 for FastCGI communication
EXPOSE 9000

# The base PHP-FPM image defines the CMD ["php-fpm"]

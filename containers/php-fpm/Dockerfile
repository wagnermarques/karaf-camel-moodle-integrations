# ./php-fpm/Dockerfile
ARG PHP_VERSION=8.2
FROM php:${PHP_VERSION}-fpm-alpine

# Set working directory
WORKDIR /var/www/html

# Install essential PHP extensions for web development and database access
# pdo_pgsql for PostgreSQL, pdo_mysql for MariaDB/MySQL
# You might need others like: gd, intl, zip, bcmath, soap, etc.
# Add build dependencies, install extensions, then remove dependencies

# Update package index
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirror.ufscar.br.alpinelinux.org/' /etc/apk/repositories
RUN apk update

# Install build dependencies
#RUN apk add postgresql-dev mariadb-dev libzip-dev libpng-dev libjpeg-dev freetype-dev libldap aspell

#RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS 

# Configure gd extension
#RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# Install core PHP extensions
#RUN docker-php-ext-install pdo pdo_pgsql pdo_mysql curl gd intl mbstring opcache pcntl sodium tokenizer xmlrpc zip bcmath soap ldap exif xsl

# Install PECL extensions
#RUN pecl install redis imagick enchant gmp tidy

# Enable PECL extensions
#RUN docker-php-ext-enable redis imagick enchant gmp tidy

# Remove build dependencies
#RUN apk del .build-deps

# Install composer (Optional but common)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy custom php.ini settings
COPY php.ini /usr/local/etc/php/conf.d/custom-php.ini

# Expose port 9000 for FastCGI communication
EXPOSE 9000

# The base PHP-FPM image defines the CMD ["php-fpm"]


# ./php-fpm/Dockerfile
ARG PHP_VERSION=8.2
FROM php:${PHP_VERSION}-fpm-alpine


# Define build arguments for environment variables
ARG TZ
ARG DB_POSTGRES_HOST
ARG DB_POSTGRES_PORT
ARG DB_POSTGRES_DATABASE
ARG DB_POSTGRES_USER
ARG DB_POSTGRES_PASSWORD
ARG DB_MARIADB_HOST
ARG DB_MARIADB_PORT
ARG DB_MARIADB_DATABASE
ARG DB_MARIADB_USER
ARG DB_MARIADB_PASSWORD


# Set environment variables (these will be available at runtime)
ENV TZ=${TZ:-UTC}
ENV DB_POSTGRES_HOST=${DB_POSTGRES_HOST:-db_postgres}
ENV DB_POSTGRES_PORT=${DB_POSTGRES_PORT:-5432}
ENV DB_POSTGRES_DATABASE=${DB_POSTGRES_DATABASE}
ENV DB_POSTGRES_USER=${DB_POSTGRES_USER}
ENV DB_POSTGRES_PASSWORD=${DB_POSTGRES_PASSWORD}
ENV DB_MARIADB_HOST=${DB_MARIADB_HOST:-db_mariadb}
ENV DB_MARIADB_PORT=${DB_MARIADB_PORT:-3306}
ENV DB_MARIADB_DATABASE=${DB_MARIADB_DATABASE}
ENV DB_MARIADB_USER=${DB_MARIADB_USER}
ENV DB_MARIADB_PASSWORD=${DB_MARIADB_PASSWORD}

# Set working directory
WORKDIR /var/www/html

# Install essential PHP extensions for web development and database access
# pdo_pgsql for PostgreSQL, pdo_mysql for MariaDB/MySQL
# You might need others like: gd, intl, zip, bcmath, soap, etc.
# Add build dependencies, install extensions, then remove dependencies

# Update package index
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirror.ufscar.br.alpinelinux.org/' /etc/apk/repositories
RUN apk update


# Install build dependencies required for PHP extensions
RUN apk add --no-cache \
    libjpeg-turbo \
    libgomp \
    curl \
    libcurl \
    curl-dev \
    postgresql-dev \ 
    mariadb-dev \
    libpng-dev \
    freetype-dev \
    tidyhtml-dev \        
    libzip-dev \
    libldap \
    aspell \
    oniguruma-dev \ 
    oniguruma \
    libsodium \
    libsodium-dev \
    libxml2-dev \
    libzip \
    libzip-dev \
    libpng \
    libjpeg-turbo \
    libjpeg-turbo-dev \
    freetype \
    freetype-dev \
    libpng \
    libpng-dev \
    libxslt-dev \
    libxml2-dev \
    imagemagick-dev \
    imagemagick 

#RUN apk add --no-cache --virtual .build-deps  $PHPIZE_DEPS 
    

# Configure and install essential and common PHP extensions for Moodle
#RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
RUN docker-php-ext-configure gd --with-freetype && \
    docker-php-ext-install -j "$(nproc)" \
    pdo \
    pdo_pgsql \
    pdo_mysql \
    tidy  \
    curl \
    gd \
    intl \
    mbstring \
    opcache \
    pcntl \
    sodium \
    zip \
    bcmath \
    exif \
    xsl

# Install composer (Optional but common)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy custom php.ini settings
COPY php.ini /usr/local/etc/php/conf.d/custom-php.ini

# Expose port 9000 for FastCGI communication
EXPOSE 9000

# The base PHP-FPM image defines the CMD ["php-fpm"]


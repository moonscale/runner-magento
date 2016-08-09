FROM php:5.6-apache

ENV DEBCONF_FRONTEND non-interactive

ADD bin/docker-php-pecl-install /usr/local/bin/

RUN apt-get update && apt-get install -y \
        git \
        imagemagick \
        libcurl4-openssl-dev \
        libfreetype6-dev \
        libicu-dev \
        libjpeg-turbo-progs \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxml2-dev \
        libxslt-dev \
        mysql-client \
        pngquant \
        ssmtp \
        sudo \
        unzip \
        wget \
        zlib1g-dev \
    && docker-php-ext-install \
        bcmath \
        curl \
        exif \
        intl \
        mbstring \
        mcrypt \
        mysql \
        mysqli \
        opcache \
        pcntl \
        pdo_mysql \
        simplexml \
        soap \
        xml \
        xsl \
        zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && apt-get clean \
    && docker-php-pecl-install \
        memcache \
        uploadprogress

ADD ./conf/php-magento.ini /usr/local/etc/php/conf.d/php-magento.ini

RUN cd /usr/local \
    && curl -sS https://getcomposer.org/installer | php \
    && chmod +x /usr/local/composer.phar \
    && ln -s /usr/local/composer.phar /usr/local/bin/composer

RUN wget https://files.magerun.net/n98-magerun.phar -O /usr/local/bin/magerun \
	&& chmod +x /usr/local/bin/magerun

RUN a2enmod deflate \
	&& a2enmod expires \
	&& a2enmod headers \
	&& a2enmod mime \
	&& a2enmod rewrite

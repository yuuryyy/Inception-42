FROM debian:11-slim

# WORKDIR /the/workdir/path

ARG WORDPRESS_VERSION=6.4.1
ARG PHP_VERSION=7.4


ENV WORDPRESS_PATH=/var/www/html

ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && \
    apt-get install -y \
    wget \
    unzip \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php-cli \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp-cli

RUN sed -i "s#listen = /run/php/php/php7.4-fpm.sock#listen = 0.0.0.0:9000#"  /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

RUN mkdir -p ${WORDPRESS_PATH}


RUN wget https://wordpress.org/wordpress-${WORDPRESS_VERSION}.zip -O /tmp/wordpress.zip && \
    # Unzip the downloaded file into a temporary directory.
    unzip /tmp/wordpress.zip -d /tmp && \
    # Move the contents from the temporary '/tmp/wordpress' folder to our final destination.
    mv /tmp/wordpress/* ${WORDPRESS_PATH}/ && \
    # Clean up the temporary zip file and directory to keep the image small.
    rm -rf /tmp/wordpress.zip /tmp/wordpress




# COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/.
COPY ./conf/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh


ENTRYPOINT [ "entrypoint.sh" ]

EXPOSE 9000

# CMD [ "sleep", "infinity" ]


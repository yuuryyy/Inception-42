FROM debian:11-slim

ARG PHP_VERSION=7.4

# Install all necessary packages. We are the 'root' user here.
RUN apt-get update && \
    apt-get install -y wget php${PHP_VERSION}-fpm php${PHP_VERSION}-cli php${PHP_VERSION}-mysql && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php && sed -i 's#listen = /run/php/php7.4-fpm.sock#listen = 9000#' /etc/php/7.4/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp-cli

COPY ./conf/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD [ "php-fpm7.4","-F" ]

FROM debian:11-slim

ARG WORDPRESS_VERSION=6.4.1
ARG PHP_VERSION=7.4

ENV DEBIAN_FRONTEND=noninteractive

# Install all necessary packages. We are the 'root' user here.
RUN apt-get update && \
    apt-get install -y wget unzip php${PHP_VERSION}-fpm php${PHP_VERSION}-cli php${PHP_VERSION}-mysql && \
    rm -rf /var/lib/apt/lists/*

# Install wp-cli.
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp-cli

# --- THE DEFINITIVE FIX ---
# Configure PHP-FPM to listen on the network.
# We DO NOT change the 'user' or 'group' directives. We leave them as 'www-data'.
RUN sed -i 's#listen = /run/php/php7.4-fpm.sock#listen = 9000#' /etc/php/7.4/fpm/pool.d/www.conf

# Create the required directories as root.
RUN mkdir -p /var/www/html
RUN mkdir -p /run/php

# Download and place the WordPress files. They will be owned by root initially.
RUN wget https://wordpress.org/wordpress-${WORDPRESS_VERSION}.zip -O /tmp/wp.zip && \
    unzip /tmp/wp.zip -d /var/www/html && \
    mv /var/www/html/wordpress/* /var/www/html/ && \
    rm -rf /var/www/html/wordpress /tmp/wp.zip

# --- CRITICAL PERMISSIONS STEP ---
# As the root user, we now give ownership of the web files and the PHP runtime
# directory to the 'www-data' user. This prepares the workspace for the FPM workers.
RUN chown -R www-data:www-data /var/www/html
RUN chown -R www-data:www-data /run/php

# Copy and prepare the entrypoint.
COPY ./conf/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

# The container will start and run the entrypoint as root.
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD [ "php-fpm7.4","-F" ]

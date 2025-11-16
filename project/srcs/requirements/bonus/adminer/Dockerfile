# ./requirements/adminer/Dockerfile

# Start from our standard Debian 11 base.
FROM debian:11-slim

# Set an argument for the Adminer version for easy updates.
ARG ADMINER_VERSION=4.8.1
# We need a version of PHP that is compatible with Adminer.
ARG PHP_VERSION=7.4

# Install only the bare minimum: `wget` to download, and the PHP command-line
# interface (`cli`) which includes the built-in server. We also need the `mysql`
# extension so PHP can talk to our MariaDB database.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget ca-certificates \
        php${PHP_VERSION}-cli \
        php${PHP_VERSION}-mysql \
    && rm -rf /var/lib/apt/lists/*

# Create a directory where the Adminer application will live.
RUN mkdir -p /var/www/html

# Download the single Adminer PHP file from its official source on GitHub.
# We rename it to `index.php` for convenience, which is the default file
# a web server looks for.
RUN wget https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php \
    -O /var/www/html/index.php

# Set the working directory for the container.
WORKDIR /var/www/html

# Expose the port that our PHP server will listen on.
EXPOSE 8080

# The command to run when the container starts.
# This starts PHP's built-in web server.
# `-S 0.0.0.0:8080`: Tells it to Serve (`-S`) on all network interfaces on port 8080.
# The server will automatically serve the `index.php` file in the current directory.
CMD ["php", "-S", "0.0.0.0:8080"]
#!/bin/bash
set -e

# This runs only on the first start.
if [ -f "/var/www/html/wp-config.php" ]; then
    echo "WordPress is already configured."
else
    echo "Configuring WordPress..."

    # Read the password from the secret file.
    DB_PASSWORD_FROM_SECRET=$(cat /run/secrets/db_password)
    WORDPRESS_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)

    # Use --allow-root because this script is running as the root user.
    wp-cli --allow-root config create \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="${DB_PASSWORD_FROM_SECRET}" \
        --dbhost="${WORDPRESS_DB_HOST}" \
        --path="/var/www/html"

    # The files are already owned by www-data, but we run chown again
    # to ensure permissions are correct on the newly created wp-config.php.
    chown -R www-data:www-data /var/www/html

    # These lines make WordPress aware of the reverse proxy.
    # It tells WordPress to build its URLs dynamically based on the incoming Host header.
    # The `\$` escapes the dollar sign so the shell doesn't interpret it.
    # The `--raw` flag tells wp-cli to insert the value as raw PHP code.
    echo "Making WordPress proxy-aware..."
    cat << EOF >> /var/www/html/wp-config.php

    #Reverse Proxy SSL Support
    if (isset(\$_SERVER['HTTP_X_FORWARDED_PROTO']) && \$_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
        \$_SERVER['HTTPS'] = 'on';
    }

    if (isset(\$_SERVER['HTTP_HOST'])) {
        define('WP_HOME', 'https://' . \$_SERVER['HTTP_HOST']);
        define('WP_SITEURL', 'https://' . \$_SERVER['HTTP_HOST']);
    }
    EOF


    # Install WordPress.
    wp-cli --allow-root core install \
        --url="https://${DOMAIN_NAME}" \
        --title="${WORDPRESS_TITLE}" \
        --admin_user="${WORDPRESS_ADMIN_USER}" \
        --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
        --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
        --path="/var/www/html"

        # --- NEW BONUS PART: CONFIGURE REDIS ---
    echo "Configuring Redis cache..."
    wp-cli --allow-root plugin install redis-cache --activate --path="/var/www/html"
    wp-cli --allow-root config set WP_REDIS_HOST redis --path="/var/www/html"
    wp-cli --allow-root config set WP_REDIS_PORT 6379 --path="/var/www/html"
    wp-cli --allow-root redis enable --path="/var/www/html"
    # --- END OF BONUS PART ---
fi

# Start the main process. This is started by root, but will spawn workers as www-data.
echo "Starting PHP-FPM..."
exec php-fpm7.4 -F
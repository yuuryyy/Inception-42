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
    
    wp-cli --allow-root core download --path="/var/www/html"
    
    wp-cli --allow-root config create \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="${DB_PASSWORD_FROM_SECRET}" \
        --dbhost="${WORDPRESS_DB_HOST}" \
        --path="/var/www/html"

    # STEP 1: Install WordPress using the required placeholder URL.
    # This will unfortunately hardcode this URL into theme settings, etc.
    wp-cli --allow-root core install \
        --url="https://${DOMAIN_NAME}" \
        --title="${WORDPRESS_TITLE}" \
        --admin_user="${WORDPRESS_ADMIN_USER}" \
        --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
        --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
        --path="/var/www/html"
    
    # --- CONFIGURE REDIS ---
    echo "Configuring Redis cache..."
    wp-cli --allow-root plugin install redis-cache --activate --path="/var/www/html"
    wp-cli --allow-root config set WP_REDIS_HOST "${REDIS_HOST}" --path="/var/www/html"
    wp-cli --allow-root config set WP_REDIS_PORT "${REDIS_PORT}" --path="/var/www/html"
    wp-cli --allow-root redis enable --path="/var/www/html"


    # --- CRITICAL PERMISSIONS STEP ---
    # As the root user, we now give ownership of the web files and the PHP runtime
    # directory to the 'www-data' user. This prepares the workspace for the FPM workers.
    chown -R www-data:www-data /var/www/html
    chown -R www-data:www-data /run/php
fi

# Start the main process. This is started by root, but will spawn workers as www-data.
echo "Starting PHP-FPM..."
exec "$@"
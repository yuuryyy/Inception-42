#!/bin/bash

# Exit immediately if a command fails.
set -e

# Check if WordPress is already configured by looking for wp-config.php.
if [ -f "/var/www/html/wp-config.php" ]; then
    echo "WordPress is already configured."
else
    # This block only runs on the first start.
    echo "Configuring WordPress for the first time..."

    WORDPRESS_DB_PASSWORD=$(cat /run/secrets/db_password)
    # Use wp-cli to create the wp-config.php file from environment variables.
    wp-cli --allow-root config create \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="${WORDPRESS_DB_PASSWORD}" \
        --dbhost="${WORDPRESS_DB_HOST}" \
        --path="/var/www/html"

    # Set the correct file permissions for the 'www-data' user.
    chown -R www-data:www-data /var/www/html
fi

# This is the final command of the script.
echo "Starting PHP-FPM..."

# === CHANGED HERE ===
# Execute the specific version of PHP-FPM for 7.4.
# The executable is named `php-fpm7.4`.
exec php-fpm7.4 -F
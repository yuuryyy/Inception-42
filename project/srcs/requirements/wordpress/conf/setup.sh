#!/bin/bash
    # This is called a "shebang," 
    # and it tells the operating system (the Linux inside your container) 
    # to execute the rest of the file using the Bash shell interpreter.



    # This command changes the current directory to /var/www/html. 
    # This is the web root directory where Nginx expects to find the website's files. 
    # All subsequent commands will be run from this location.
cd /var/www/html

    # This downloads WP-CLI (WordPress Command-Line Interface).
    #  WP-CLI is a powerful tool that allows you to manage WordPress from
    #  the command line instead of a web browser.
    # curl -O downloads the file and saves it with its original name, wp-cli.phar.
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

    # This makes the wp-cli.phar file executable. By default, 
    # downloaded files don't have permission to be run as programs.
chmod +x wp-cli.phar

    # This command uses WP-CLI to download the actual WordPress core files 
    #(the latest version) into the current directory (/var/www/html).
    # --allow-root is required because WP-CLI normally warns you against running as the root
    #  user for security reasons. In a controlled Docker environment, this is a necessary override
./wp-cli.phar core download --allow-root

    # this is one of the most important steps. It automatically creates your wp-config.php file,
    #  which tells WordPress how to connect to your database.
    # --dbname=wordpress: Sets the database name.
    # --dbuser=wpuser: Sets the database username.
    # --dbpass=password: Sets the database password for that user.
    # --dbhost=mariadb: This is crucial for Docker. It tells WordPress that the database
    #  server is located at the hostname mariadb. Docker's internal networking will resolve mariadb 
    # to the IP address of your MariaDB container, as defined in your docker-compose.yml.
./wp-cli.phar config create --dbname=wordpress --dbuser=wpuser --dbpass=password --dbhost=mariadb --allow-root

    # This command runs the famous WordPress installation process. 
    # It populates the database with the necessary tables and sets up your site.
    # --url=localhost: Sets your website's address.
    # --title=inception: Sets the title of your new website.
    # --admin_user=admin: Creates the main administrator account with the username admin.
    # --admin_password=admin: Sets the password for the admin account.
    # --admin_email=admin@admin.com: Sets the administrator's email
./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root

    # This is the final and most important command. It starts the PHP-FPM (FastCGI Process Manager) service. 
    # This is the actual PHP engine that receives requests from Nginx, processes the WordPress PHP code, 
    # and sends the result back to Nginx to be displayed.
    # The -F flag is essential for Docker. It tells PHP-FPM to run in the Foreground. 
    # A Docker container stays alive only as long as its main process is running. 
    # If you didn't use -F, PHP-FPM would start in the background (as a daemon), 
    # the script would immediately end, and the container would shut down. 
    # Running it in the foreground keeps the container alive and ready to handle requests.
php-fpm7.4 -F
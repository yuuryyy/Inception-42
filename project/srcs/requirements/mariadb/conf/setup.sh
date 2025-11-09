#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
sed -e


# # Define the data directory
DATADIR="/var/lib/mysql"



    # # find "$DATADIR" -mindepth 1 -print -quit: This is a clever and efficient way 
    # # to check if a directory is empty. It starts looking inside $DATADIR for any file 
    # # or subdirectory. As soon as it finds the very first item, 
    # # it prints its name (-print) and immediately stops (-quit).

#     # "$(...)": The output of the find command is captured. If the directory
#     #  is empty, the command finds nothing and produces no output 
#     #  (an empty string). If the directory contains anything, 
#     #  it produces a non-empty string (the name of the first file it found).

#     # [ -z "..." ]: This tests if the string
#     #  from the command is empty (-z).

#     # Result: The entire if block will only run if /var/lib/mysql is 
#     # completely empty. On subsequent container restarts where a volume
#     # is attached, this directory will not be empty, and the script will 
#     # skip straight to the end to start the server.

if [ -z "$(find "$DATADIR" -mindepth 1 -print -quit)" ]; then
    echo "Data directory is empty. Initializing MariaDB..."

         # 1. Initialize the database data directory
        # This command creates the fundamental system
        # tables and databases (like mysql, performance_schema)
        #  that MariaDB needs to function. --user=mysql is crucial 
        #  for setting the correct file permissions, as the server will
        #   run as the mysql user.
    mariadb-install-db --datadir="$DATADIR"

	#: Starts a temporary MariaDB server in the background to perform the setup.
	#mysqld: The MariaDB server program
	#--skip-networking: A security measure. It tells the server not to listen 
	#for connections over the network (like TCP/IP). It will only accept 
	#local connections via a socket file, 
	#which is all we need for the script to connect to it.
	#&: The ampersand runs the process in the background. This is critical because 
	#otherwise, the script would just hang here forever 
	#waiting for the server to stop.
    mysqld  --datadir="$DATADIR" --skip-networking &
    
     #Saves the Process ID (PID) of the temporary server.
     #$! is a special Bash variable that always contains the 
     #PID of the most recent background process. 
     #We save it to the pid variable so we can gracefully 
     #shut down this specific process later.
  pid="$!"


        # 3. Wait for the server to be ready
	# The until loop repeatedly runs mariadb-admin ping
    until mariadb-admin ping --silent; do
        echo "Waiting for MariaDB to start..."
        sleep 2
    done

    # 4. Perform initial setup (create user, database, etc.)
    # Executes the necessary SQL commands to create the application's user and database.
    #It feeds all the lines of SQL between <<EOF and EOF directly 
    #to the mariadb client. It uses environment variables
   # (like ${MARIADB_DATABASE}) that you would pass into
   #  the Docker container (e.g., in your docker-compose.yml file) 
   #  to create the user and database dynamically.
    mariadb <<EOF
        CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;
        CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO \`${MARIADB_USER}\`@'%';
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
	-- Delete the anonymous user accounts.
	DELETE FROM mysql.user WHERE User = '';

	-- Delete the remote root user.
	-- The NOT IN clause is robust, covering hostname, IPv4, and IPv6 loopback addresses.
	DELETE FROM mysql.user WHERE User = 'root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

	-- Drop the default 'test' database.
	DROP DATABASE IF EXISTS test;
        FLUSH PRIVILEGES;
EOF

    # 5. Shut down the temporary server
    # use the root password to shut it down 
        # Shut down the temporary server
    # Use the root password to shut it down now that it's set.
    if ! mariadb-admin -u root -p"${MARIADB_ROOT_PASSWORD}" shutdown; then
        echo >&2 'MariaDB init process failed.'
        exit 1
    fi

    # Wait for the process to fully stop.
    wait "$pid"
fi

echo "Starting MariaDB server..."
exec mysqld --user=mysql --datadir="$DATADIR"

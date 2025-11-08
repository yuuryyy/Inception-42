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
    mariadb-install-db --user=mysql --datadir="$DATADIR"


        
    mysqld --user=mysql --datadir="$DATADIR" --skip-networking &
    pid="$!"
# # error check if fails
# mysql_install_db


# # check if already user exists
# mysqld


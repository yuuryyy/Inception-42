#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Define the data directory
DATADIR="/var/lib/mysql"



# error check if fails
mysql_install_db


# check if already user exists
mysqld

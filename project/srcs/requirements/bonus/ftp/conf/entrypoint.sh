#!/bin/bash

# This script will run every time the container starts.
# We will check if the user has already been configured to avoid errors on restart.

# Check for a "flag" file. If it doesn't exist, this is the first run.
if [ ! -f "/etc/ftp_user_configured" ]; then
    echo "Configuring FTP user for the first time..."

    # Read the password from the Docker Secret file.
    FTP_PASSWORD_FROM_SECRET=$(cat /run/secrets/ftp_password)

    # Use 'chpasswd' to set the password for the user that was created in the Dockerfile.
    echo "${FTP_USER}:${FTP_PASSWORD_FROM_SECRET}" | chpasswd

    # Create the flag file to prevent this block from running again.
    touch /etc/ftp_user_configured

    echo "FTP user configured successfully."
fi

# This is the final command. It starts the vsftpd server in the foreground.
echo "Starting vsftpd..."
exec vsftpd /etc/vsftpd.conf
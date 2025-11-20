# ./requirements/ftp/Dockerfile

FROM debian:11-slim

# The username is configuration, not a secret, so it's passed as an ARG.
ARG FTP_USER

# Install the vsftpd server.
RUN apt-get update && \
    apt-get install -y vsftpd && \
    rm -rf /var/lib/apt/lists/*

# Create the user's home directory and the user itself, WITHOUT setting a password yet.
# The user will exist but be unable to log in until the entrypoint script runs.
RUN useradd -m -d /var/www/html ${FTP_USER}

RUN mkdir -p /var/run/vsftpd/empty

# Copy our custom vsftpd configuration file.
COPY ./conf/vsftpd.conf /etc/vsftpd.conf

# --- NEW: Copy and prepare the entrypoint script ---
COPY ./conf/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose the necessary ports.
EXPOSE 21
EXPOSE 21100-21110

# Set the entrypoint to our new script.
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

# CMD [ "sleep", "infinity" ]

# The CMD is now handled by the 'exec' line in the entrypoint script.
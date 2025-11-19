
FROM debian:11-slim

ARG PORTAINER_VERSION=2.19.4

# `wget` to download and `tar` to extract.
# `ca-certificates` is required for `wget` to validate the HTTPS connection.
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget tar ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# the official Portainer Community Edition binary for Linux AMD64.
RUN wget "https://github.com/portainer/portainer/releases/download/${PORTAINER_VERSION}/portainer-${PORTAINER_VERSION}-linux-amd64.tar.gz" -O /tmp/portainer.tar.gz

# Extract the archive. The contents will be in a `/portainer` directory.
RUN tar -xvzf /tmp/portainer.tar.gz -C /

# the directory where Portainer will store its persistent data
# (user accounts, settings, etc.).
RUN mkdir -p /data

# Expose the port for the Portainer web UI (HTTPS).
EXPOSE 9443

# The command to start the Portainer server.
# It points to the binary we extracted and tells it where to store its data.
CMD ["/portainer/portainer", "--data", "/data"]
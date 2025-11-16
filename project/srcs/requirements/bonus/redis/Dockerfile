# ./requirements/redis/Dockerfile

# Start from our standard Debian 11 base.
FROM debian:11-slim

# Install the Redis server directly from the official Debian repositories.
# This is simple, fast, and reliable.
RUN apt-get update && \
    apt-get install -y redis-server && \
    rm -rf /var/lib/apt/lists/*

# --- Configuration for Docker ---
# We need to make two changes to the default configuration file.
RUN sed -i 's/bind 127.0.0.1 ::1/bind 0.0.0.0/' /etc/redis/redis.conf && \
    # 1. 'bind 0.0.0.0': Allow connections from other containers (like WordPress).
    sed -i 's/protected-mode yes/protected-mode no/' /etc/redis/redis.conf && \
    # 2. 'daemonize no': Force Redis to run in the foreground, which is essential for Docker.
    sed -i 's/daemonize yes/daemonize no/' /etc/redis/redis.conf

# Expose the default Redis port so other containers can connect.
EXPOSE 6379

# The command to start the Redis server when the container runs.
# We point it to the configuration file we just modified.
CMD [ "redis-server", "/etc/redis/redis.conf" ]

FROM debian:11-slim

# Install wget and unzip, which we need to download and extract ngrok.
# ca-certificates is required to validate the HTTPS connection to ngrok's site.
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget unzip ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Download the ngrok binary for Linux AMD64 architecture.
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip -O /tmp/ngrok.zip

# Unzip the binary and place it in a runnable location.
RUN unzip /tmp/ngrok.zip -d /usr/local/bin

COPY ./conf/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 4040

# The ENTRYPOINT is now our script.
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]


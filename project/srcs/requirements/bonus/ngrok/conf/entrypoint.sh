#!/bin/sh

# Exit immediately if a command fails.
set -e

echo "Configuring ngrok authtoken..."

# Read the authtoken from the Docker Secret file and configure ngrok.
# The secret is expected to be mounted at /run/secrets/ngrok_authtoken.
ngrok config add-authtoken $(cat /run/secrets/ngrok_authtoken)

echo "Starting ngrok tunnel..."

# This is the final command. `exec` replaces the script process with the ngrok process,
# making it the main process (PID 1) of the container.
# All arguments passed to this script (the CMD from the Dockerfile) are appended here.
exec ngrok http "https://nginx:443" --host-header="$DOMAIN_NAME" --log=stdout
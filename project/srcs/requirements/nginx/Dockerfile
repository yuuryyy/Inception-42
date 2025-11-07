FROM debian:11-slim

# WORKDIR /the/workdir/path

# RUN apt-get update && apt-get install -y nginx

COPY ./conf/default /etc/nginx/sites-available/.



HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "true" ]

EXPOSE 443

# ENTRYPOINT [ "executable" ]
CMD [ "nginx", "-g", "daemon off;"]

# CMD [ "sleep", "infinity" ]
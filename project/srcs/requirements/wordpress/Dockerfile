FROM debian:11-slim

# WORKDIR /the/workdir/path

# RUN apt-get update && apt-get install -y php-fpm \
#     php-cli \
#     php-mysqli\
#     curl\
#     && rm -rf /var/lib/apt/lists/* \
#     && mkdir -p /run/php

# COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/.
# COPY ./conf/setup.sh /usr/local/bin/setup.sh

# RUN chmod +x /usr/local/bin/setup.sh



HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "true" ]

EXPOSE 9000

# ENTRYPOINT [ "executable" ]
# CMD [ "setup.sh" ]

CMD [ "sleep", "infinity" ]
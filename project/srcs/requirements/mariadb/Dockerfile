
FROM debian:11-slim

#installing the mariadb server and cleaning pm cashe to minimalize the size of the image
EXPOSE 3306

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/list/*

RUN rm -rf /var/lib/mysql/*

RUN sed  -i "s/= 127.0.0.1/= 0.0.0.0/g"  /etc/mysql/mariadb.conf.d/50-server.cnf

# The copy command is used to copy the file/folders to the image while building the image. 
COPY ./conf/setup.sh /usr/local/bin/setup.sh

RUN mkdir /run/mysqld && \
	  chown -R mysql:mysql /run/mysqld && \
	  chmod +x /usr/local/bin/setup.sh


# HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "true" ]


 ENTRYPOINT [ "setup.sh" ]
# CMD [ "setup.sh" ]

#CMD [ "sleep", "infinity" ]

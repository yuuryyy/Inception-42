FROM debian:11-slim

# WORKDIR /the/workdir/path

ARG DOMAIN_NAME

RUN apt-get update && apt-get install -y nginx openssl  gettext-base && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

#this is like telling it "    "Hey OpenSSL, I want you to make a certificate request,
# but turn it into a self-signed x.509 certificate right away. Don't password-protect 
#the private key. Make the certificate last for 365 days. While you're at it, generate 
#a new 2048-bit RSA key and save the private key to /etc/nginx/ssl/nginx.key and the 
#public certificate to /etc/nginx/ssl/nginx.crt. For the certificate's identity, 
#use the following subject information: Country=MA, State=Khouribga, City=Khouribga,
# Organization=1337, and critically, the Common Name must be the value of the DOMAIN_NAME variable.""
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out\
     /etc/nginx/ssl/nginx.crt -subj "/C=MA/ST=Khouribga/L=Khouribga/O=1337/CN=${DOMAIN_NAME}"


COPY ./nginx/conf/nginx.conf /etc/nginx/templates/default.conf.template

# Use `envsubst` to substitute the variable and create the final config file
RUN envsubst '$${DOMAIN_NAME}' < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf

# --- THIS IS THE KEY CHANGE ---
# Create the root directory for the bonus site inside the image.
RUN mkdir -p /var/www/bonus
# COPY the source files from your local machine into the image's filesystem.
# The source path is relative to the build context defined in docker-compose.yml.
COPY ../bonus/static_ws/* /var/www/bonus/

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;"]

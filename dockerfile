FROM debian:stable  

RUN apt update && apt install -y vim nginx

WORKDIR /currentdir

COPY . .

EXPOSE 80

ENTRYPOINT ["sh", "-c", "echo 'Hello from Docker Container!' ; nginx -g 'daemon off;'"]
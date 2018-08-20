FROM alpine:latest

ENV YOUR_NAME "World"

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
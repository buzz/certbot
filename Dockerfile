FROM alpine:3.16

COPY entrypoint.sh /entrypoint.sh

RUN set -xe && \
    apk update && \
    apk upgrade && \
    chmod +x /entrypoint.sh && \
    apk add bash certbot && \
    rm -rf /var/cache/apk/*

ENV DOMAINS example.com

VOLUME "/var/www/acme-challenges"

ENTRYPOINT "/entrypoint.sh"

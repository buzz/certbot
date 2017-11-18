FROM alpine:3.6

COPY entrypoint.sh /entrypoint.sh

RUN set -xe && \
    apk update && \
    apk upgrade && \
    chmod +x /entrypoint.sh && \
    apk add bash certbot && \
    rm -rf /var/cache/apk/*

COPY renew.sh /etc/periodic/daily/renew.sh

ENV DOMAINS example.com

VOLUME "/var/www/acme-challenges"

ENTRYPOINT "/entrypoint.sh"

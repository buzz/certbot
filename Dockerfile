FROM alpine:3.5

COPY entrypoint.sh /entrypoint.sh
COPY renew.sh /etc/periodic/daily/renew.sh

RUN set -xe && \
    apk update && \
    apk upgrade && \
    chmod +x /entrypoint.sh && \
    chmod +x /etc/periodic/daily/renew.sh && \
    apk add certbot && \
    rm -rf /var/cache/apk/*

ENV DOMAINS example.com

VOLUME "/var/www/acme-challenges"

ENTRYPOINT "/entrypoint.sh"

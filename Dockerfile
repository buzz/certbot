FROM alpine:3.5

COPY entrypoint.sh /entrypoint.sh

RUN set -xe && \
    apk update && \
    apk upgrade && \
    chmod +x /entrypoint.sh && \
    apk add bash certbot && \
    rm -rf /var/cache/apk/*

COPY renew.sh /etc/periodic/daily/renew.sh

# daily check
RUN set -xe && \
    chmod +x /etc/periodic/daily/renew.sh && \
    echo "0 2 * * * run-parts /etc/periodic/daily" > /etc/crontabs/root

ENV DOMAINS example.com

VOLUME "/var/www/acme-challenges"

ENTRYPOINT "/entrypoint.sh"

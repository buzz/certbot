#!/bin/bash

set -e

MAX_LOG_BACKUPS=10

# create certificate for domain if it doesn't exist
IFS=$'\n'
for domain in $DOMAINS; do
    if [ ! -d "/etc/letsencrypt/live/$domain" ]
    then
        certbot \
            certonly \
            --text \
            --agree-tos \
            --rsa-key-size 4096 \
            --email "certs@$domain" \
            --webroot \
            --webroot-path /var/www/acme-challenges \
            --non-interactive \
            --max-log-backups $MAX_LOG_BACKUPS \
            -d $domain
    fi
done

# renew once a day
while true; do
    sleep 86400
    certbot renew --max-log-backups $MAX_LOG_BACKUPS --quiet --non-interactive
done

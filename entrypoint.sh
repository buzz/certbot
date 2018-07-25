#!/bin/bash

set -e

# init certbot
IFS=':' read -ra ADDR <<< "$DOMAINS"
for DOMAIN in "${ADDR[@]}"; do
    if [ ! -d "/etc/letsencrypt/live/$DOMAIN" ]
    then
        certbot \
            certonly \
            --text \
            --agree-tos \
            --rsa-key-size 4096 \
            --email "certs@$DOMAIN" \
            --webroot \
            -w /var/www/acme-challenges \
            -n \
            -d $DOMAIN
    fi
done

# renew once a day
while true; do
    sleep 86400
    certbot renew -q -n
done

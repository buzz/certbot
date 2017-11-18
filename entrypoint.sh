#!/bin/bash

set -xe

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
            -d $DOMAIN
    fi
done

# keep running!
while true;
    do sleep 10000;
done

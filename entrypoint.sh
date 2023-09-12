#!/bin/bash

set -e

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
            -w /var/www/acme-challenges \
            -n \
            -d $domain
    fi
done

# renew once a day
while true; do
    sleep 86400
    certbot renew -q -n
done

Dockerfile for Certbot
======================

This is a Dockerfile for free and automatic [Let's Encrypt](https://letsencrypt.org/)
certificates.

* Is based on [Alpine Linux](https://alpinelinux.org).
* Uses [Certbot](https://github.com/certbot/certbot).

Once a day it renews certificates automatically if needed.

You can manually trigger certificate renewal:

```
$ docker-compose exec certbot certbot renew -q
```

Usage
-----

Use with `docker-compose.yml`:

```
services:
  certbot:
    container_name: certbot
    build: github.com/buzz/certbot
    restart: always
    depends_on:
    - nginx
    volumes:
    - ./volumes/www/acme-challenges:/var/www/acme-challenges
    - ./volumes/etc/letsencrypt:/etc/letsencrypt
    environment:
    - DOMAINS=example1.com:example2.org
  nginx:
    container_name: nginx
    image: nginx:alpine
    restart: always
    ports:
    - 80:80
    - 443:443
    volumes:
    - ./volumes/www:/var/www
    - ./volumes/etc/nginx:/etc/nginx:ro
    - ./volumes/etc/letsencrypt:/etc/letsencrypt:ro
```

#!/bin/bash
set -e
# openssl for nginx ssl certs
apt-get update && apt-get install -y openssl
if [ ! -d /etc/nginx/ssl ]; then
  mkdir -p /etc/nginx/ssl
fi
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/ssl_certificate.key \
  -out /etc/nginx/ssl/ssl_certificate.crt \
  -subj "/C=JO/ST=Amman/L=Amman/O=42Inception/OU=Student/CN=loay.42.fr"

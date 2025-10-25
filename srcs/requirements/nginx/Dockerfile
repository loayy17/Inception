FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y nginx curl && \
    rm -rf /var/lib/apt/lists/*

COPY tools/ /tmp/tools/
RUN chmod +x /tmp/tools/setup_nginx.sh
RUN /tmp/tools/setup_nginx.sh
COPY conf/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

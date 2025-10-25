FROM debian:bullseye-slim
RUN apt-get update && apt-get upgrade -y  && \
    apt-get install -y php-fpm php-mysql curl mariadb-client && rm -rf /var/lib/apt/lists/*

COPY tools/ /tmp/tools/

RUN chmod +x /tmp/tools/setup_wordpress.sh
ENTRYPOINT [ "/tmp/tools/setup_wordpress.sh" ]
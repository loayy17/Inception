FROM debian:bullseye-slim
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y mariadb-server
COPY ./tools/setup_mariadb.sh /setup.sh
RUN chmod +x /setup.sh
ENTRYPOINT [ "/setup.sh" ]
FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y -q && \
  apt-get install -y mysql-client-5.6 nodejs-legacy npm && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN npm install -g n azure-cli
RUN n 0.12.7

ADD backup.sh /backup.sh
RUN chmod 0755 /backup.sh

EXPOSE 3306

ENTRYPOINT ["/backup.sh"]

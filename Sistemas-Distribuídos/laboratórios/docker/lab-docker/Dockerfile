FROM ubuntu:24.04

RUN apt update \
    && apt install -y nyancat figlet\
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY mensagem.txt /app

COPY entrypoint.sh /app

RUN chmod +x entrypoint.sh

#ENTRYPOINT [ "/app/entrypoint.sh" ]
FROM node:16-alpine

RUN apk add --no-cache ffmpeg iproute2 git sqlite3 build-base g++ cairo-dev jpeg-dev pango-dev giflib-dev python3 ca-certificates tzdata dnsutils build-essential wget gnupg
RUN apk add --update  --repository http://dl-3.alpinelinux.org/alpine/edge/testing libmount ttf-dejavu ttf-droid ttf-freefont ttf-liberation fontconfig
RUN apt update \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
        --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \ 

ENV         USER=container HOME=/home/container
WORKDIR     /home/container

RUN         groupadd -r container && useradd -d /home/container -r -g container -G audio,video container

USER        container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
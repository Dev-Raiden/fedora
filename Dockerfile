FROM node:16-buster-slim

LABEL       author="Amelia Kiara" maintainer="amelia@kiara.my.id"

RUN         apt update \
            && apt -y install ffmpeg iproute2 git sqlite3 python3 tzdata ca-certificates dnsutils build-essential \
            && npm -g install npm@latest \
            && useradd -m -d /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
CMD         ["/bin/bash", "/entrypoint.sh"]
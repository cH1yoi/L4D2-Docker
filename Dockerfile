FROM debian:stable-slim AS install_system

RUN dpkg --add-architecture i386 && apt-get update && \
    apt-get install -y --no-install-recommends \
    wget ca-certificates tar lib32gcc-s1 lib32stdc++6 lib32z1 \
    locales && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN useradd -m -s /bin/bash hana
USER hana
WORKDIR /home/hana

FROM install_system AS install_game

RUN wget -q https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xzf steamcmd_linux.tar.gz && \
    rm steamcmd_linux.tar.gz

RUN ./steamcmd.sh +force_install_dir ./l4d2 \
    +@sSteamCmdForcePlatformType windows \
    +login anonymous \
    +app_update 222860 validate \
    +quit && \
    ./steamcmd.sh +force_install_dir ./l4d2 \
    +@sSteamCmdForcePlatformType linux \
    +login anonymous \
    +app_update 222860 validate \
    +quit

FROM install_game AS game

RUN mkdir -p .steam/sdk32/ && \
    ln -sf ~/l4d2/bin/steamclient.so ~/.steam/sdk32/steamclient.so && \
    rm -rf ~/steamcmd.sh ~/linux32 ~/package ~/public ~/steamapps ~/steamcmd_linux.tar.gz ~/steamcmd.sh.old

COPY --chown=hana:hana ./entrypoint.sh ./update.sh /home/hana/
RUN chmod +x /home/hana/entrypoint.sh /home/hana/update.sh

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
ARG BUILD_FROM=ghcr.io/home-assistant/base-debian:trixie-2026.11.0
FROM $BUILD_FROM

# Build and install mosquitto (no auth plugin: all clients are accepted)
WORKDIR /usr/src
ARG MOSQUITTO_VERSION=2.1.4
COPY patches/0001-Fix-builtin-websockets-dropping-the-session-on-an-empty-data-frame.patch /usr/src
RUN apt-get update \
    && apt-get install -qy --no-install-recommends \
        build-essential \
        git \
        openssl \
        patch \
        libssl-dev \
        libc-ares2 \
        libc-ares-dev \
        libcjson1 \
        libcjson-dev \
        libsqlite3-dev \
        xsltproc \
        docbook-xsl \
    \
    && git clone --depth 1 -b "v${MOSQUITTO_VERSION}" \
       https://github.com/eclipse/mosquitto \
    \
    && cd mosquitto \
    && patch -p1 < /usr/src/0001-Fix-builtin-websockets-dropping-the-session-on-an-empty-data-frame.patch \
    # Disable editline used by mosquitto_ctrl
    && sed -i 's/^WITH_EDITLINE=yes/#WITH_EDITLINE=yes/' config.mk \
    # Disable REST API
    && sed -i 's/^WITH_HTTP_API=yes/#WITH_HTTP_API=yes/' config.mk \
    && make WITH_WEBSOCKETS=yes WITH_SRV=yes \
    && make install \
    && cd .. \
    \
    && apt-get purge -y --auto-remove \
        build-essential \
        git \
        patch \
        libssl-dev \
        libc-ares-dev \
        libcjson-dev \
        libsqlite3-dev \
        xsltproc \
        docbook-xsl \
    && apt-get clean \
    && rm -fr \
        /etc/logrotate.d \
        /etc/mosquitto/* \
        /usr/src/mosquitto \
        /usr/src/*.patch \
        /var/lib/apt/lists/* \
        /root/.cache

COPY rootfs /

HEALTHCHECK --start-period=30s --start-interval=5s --interval=30s \
    CMD bash -c '</dev/tcp/127.0.0.1/1883' || exit 1

WORKDIR /

ARG BUILD_FROM=ghcr.io/hassio-addons/base-python/amd64:6.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy yq
ARG BUILD_ARCH=amd64
COPY bin/yq_${BUILD_ARCH} /usr/bin/yq

# Copy Python requirements file
COPY requirements.txt /tmp/

# Setup Matrix Synapse
RUN \
    apk add --no-cache --virtual .build-dependencies \
        build-base=0.5-r2 \
        libffi-dev=3.3-r2 \
        libjpeg-turbo-dev=2.0.6-r0	 \
        libressl-dev=3.1.5-r0 \
        libxslt-dev=1.1.34-r0 \
        linux-headers=5.7.8-r0 \
        musl-dev=1.2.2-r0 \
        postgresql-dev=13.1-r2 \
        zlib-dev=1.2.11-r3 \
    \
    && apk add --no-cache \
        libffi=3.3-r2 \
        libjpeg-turbo=2.0.6-r0 \
        libpq=13.1-r2 \
        libressl=3.1.5-r0 \
        libxslt=1.1.34-r0 \
        lua-resty-http=0.15-r0 \
        nginx-mod-http-lua=1.18.0-r13 \
        nginx=1.18.0-r13 \
        su-exec=0.2-r1 \
        tiff=4.1.0-r2 \
        zlib=1.2.11-r3 \
    \
    && pip3 install \
        --no-cache-dir \
        --find-links "https://wheels.home-assistant.io/alpine-3.11/${BUILD_ARCH}/" \
        -r /tmp/requirements.txt \
    \
    && mkdir -p /opt/riot \
    && curl -J -L -o /tmp/riot.tar.gz \
        "https://github.com/vector-im/riot-web/releases/download/v1.6.4/riot-v1.6.4.tar.gz" \
    && tar xzf /tmp/riot.tar.gz -C /opt/riot --strip 1 \
    \
    && find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    \
    && apk del --purge .build-dependencies \
    && rm -fr \
        /etc/nginx \
        /tmp/*

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Timmo <contact@timmo.xyz>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Timmo <contact@timmo.xyz>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

ARG BUILD_FROM=hassioaddons/base-python:3.0.2
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
        build-base=0.5-r1 \
        libffi-dev=3.2.1-r6 \
        libjpeg-turbo-dev=2.0.3-r0	 \
        libressl-dev=2.7.5-r0 \
        libxslt-dev=1.1.33-r2 \
        linux-headers=4.19.36-r0 \
        musl-dev=1.1.22-r3 \
        postgresql-dev=11.6-r0 \
        zlib-dev=1.2.11-r1 \
    \
    && apk add --no-cache \
        libffi=3.2.1-r6 \
        libjpeg-turbo=2.0.3-r0 \
        libpq=11.6-r0 \
        libressl=2.7.5-r0 \
        libxslt=1.1.33-r2 \
        lua-resty-http=0.13-r0 \
        nginx-mod-http-lua=1.16.1-r1 \
        nginx=1.16.1-r1 \
        su-exec=0.2-r0 \
        tiff=4.0.10-r3 \
        zlib=1.2.11-r1 \
    \
    && pip3 install \
        --no-cache-dir \
        --find-links "https://wheels.home-assistant.io/alpine-3.10/${BUILD_ARCH}/" \
        -r /tmp/requirements.txt \
    \
    && mkdir -p /opt/riot \
    && curl -J -L -o /tmp/riot.tar.gz \
        "https://github.com/vector-im/riot-web/releases/download/v1.4.0/riot-v1.4.0.tar.gz" \
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
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Matrix" \
    io.hass.description="A secure and decentralized communication platform." \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Timmo <contact@timmo.xyz>" \
    org.label-schema.description="A secure and decentralized communication platform." \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Matrix" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-matrix/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-matrix" \
    org.label-schema.vendor="Community Hass.io Add-ons"

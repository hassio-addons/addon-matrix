ARG BUILD_FROM=hassioaddons/base:3.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup Matrix Synapse
RUN \
    apk add --no-cache --virtual .build-dependencies \
        build-base=0.5-r1 \
        libffi-dev=3.2.1-r6 \
        libjpeg-turbo-dev=1.5.3-r4 \
        libressl-dev=2.7.5-r0 \
        libxslt-dev=1.1.32-r0 \
        linux-headers=4.18.13-r1 \
        musl-dev=1.1.20-r4 \
        postgresql-dev=11.1-r0 \
        python3-dev=3.6.8-r1 \
        zlib-dev=1.2.11-r1 \
    \
    && apk add --no-cache \
        libffi=3.2.1-r6 \
        libjpeg-turbo=1.5.3-r4 \
        libpq=11.1-r0 \
        libressl=2.7.5-r0 \
        libxslt=1.1.32-r0 \
        nginx=1.14.2-r0 \
        py3-lxml=4.2.5-r0 \
        py3-msgpack=0.6.1-r0 \
        py3-pillow=5.4.1-r0 \
        py3-psycopg2=2.7.5-r0 \
        py3-pynacl=1.3.0-r1 \
        py3-setuptools=40.6.3-r0 \
        py3-six=1.11.0-r0 \
        python3=3.6.8-r1 \
        su-exec=0.2-r0 \
        zlib=1.2.11-r1 \
    \
    && pip3 install --upgrade pip==19.0.3 \
    && pip3 install \
        pysaml2==4.6.5 \
        matrix-synapse==0.99.2 \
    \
    && mkdir -p /opt/riot \
    && curl -J -L -o /tmp/riot.tar.gz \
        "https://github.com/vector-im/riot-web/releases/download/v1.0.5/riot-v1.0.5.tar.gz" \
    && tar xzf /tmp/riot.tar.gz -C /opt/riot --strip 1 \
    \
    && apk del --purge .build-dependencies \
    && rm -fr /tmp/*

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
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

ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base/amd64:4.2.3
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
    apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential=12.6 \
        libffi-dev=3.2.1-9 \
        libjpeg-dev=1:1.5.2-2+deb10u1 \
        libpq-dev=11.12-0+deb10u1 \
        libssl-dev=1.1.1d-0+deb10u6 \
        libwebp-dev=0.6.1-2+deb10u1 \
        libxml++2.6-dev=2.40.1-3 \
        libxslt1-dev=1.1.32-2.2~deb10u1 \
        rustc=1.41.1+dfsg1-1~deb10u1 \
        zlib1g-dev=1:1.2.11.dfsg-1 \
        \
        python3=3.7.3-1 \
        libjpeg62-turbo=1:1.5.2-2+deb10u1 \
        libpq5=11.12-0+deb10u1 \
        libwebp6=0.6.1-2+deb10u1 \
        xmlsec1=1.2.27-2 \
        libjemalloc2=5.1.0-3 \
        openssl=1.1.1d-0+deb10u6 \
        nginx=1.14.2-2+deb10u4 \
    \
    && curl https://bootstrap.pypa.io/get-pip.py | python3 \
    && pip install --no-cache-dir \
        -r /tmp/requirements.txt \
    \
    && mkdir -p /opt/element \
    && curl -J -L -o /tmp/element.tar.gz \
        "https://github.com/vector-im/element-web/releases/download/v1.8.1/element-v1.8.1.tar.gz" \
    && tar xzf /tmp/element.tar.gz -C /opt/element --strip 1 \
    && mv /opt/element/config.sample.json /opt/element/config.json \
    \
    && find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    \
    && apt-get purge -y --auto-remove \
        build-essential \
        libffi-dev \
        libjpeg-dev \
        libpq-dev \
        libssl-dev \
        libwebp-dev \
        libxml++2.6-dev \
        libxslt1-dev \
        rustc \
        zlib1g-dev \
    \
    && rm -fr \
        /tmp/* \
        /etc/nginx \
        /var/{cache,log}/* \
        /var/lib/apt/lists/*


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

#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Matrix
# Configures NGINX for use with Riot
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare certfile
declare keyfile

# Enable SSL
if hass.config.true 'ssl'; then
    certfile=$(hass.config.get 'certfile')
    keyfile=$(hass.config.get 'keyfile')

    sed -i "s/%%certfile%%/${certfile}/g" /etc/nginx/nginx-ssl.conf
    sed -i "s/%%keyfile%%/${keyfile}/g" /etc/nginx/nginx-ssl.conf
fi

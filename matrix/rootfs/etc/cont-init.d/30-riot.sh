#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Matrix
# This files check if all user configuration requirements are met
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

if ! hass.file_exists "/config/matrix/riot.json"; then
    hass.log.info "Riot web config at does not exist. Creating.."
    mv /opt/riot-im/config.sample.json /config/matrix/riot.json
    ln -s /config/matrix/riot.json /opt/riot-im/config.json
fi

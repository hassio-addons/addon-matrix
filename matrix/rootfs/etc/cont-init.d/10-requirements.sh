#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Matrix
# This files check if all user configuration requirements are met
# ==============================================================================
# Check SSL settings
bashio::config.require.ssl

if ! bashio::config.has_value 'server_name'; then
    bashio::log.fatal ''
    bashio::log.fatal 'You must specify your server name!'
    bashio::log.fatal 'This should be the hostname of your server'
    bashio::log.fatal 'without "http://" / "https://" and the port.'
    bashio::log.fatal 'Refer to the "server_name" option in the docs for more info.'
    bashio::exit.nok
fi

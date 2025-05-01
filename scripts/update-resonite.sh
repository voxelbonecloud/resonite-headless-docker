#!/bin/sh
# vim: ts=2 sw=2 et

if [ ! -d "/home/container/steamcmd" ]; then
	echo Installing steamcmd
	mkdir -p /home/container/steamcmd
	curl -sSL -o /tmp/steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
	tar -xf /tmp/steamcmd.tar.gz --directory /home/container/steamcmd
fi

HEADLESS_DIRECTORY="/home/container/Headless"

STEAMCMD_BETA_PASSWORD=""

if [ ! "${BETA_CODE}" = "" ]; then
  STEAMCMD_BETA_PASSWORD="-betapassword ${BETA_CODE}"
fi

/home/container/steamcmd/steamcmd.sh +login ${STEAM_USER} ${STEAM_PASS} +force_install_dir /home/container +app_license_request 2519830 +app_update 2519830 -beta ${STEAM_BRANCH} ${STEAMCMD_BETA_PASSWORD} validate +quit

exec $*

#!/bin/sh
# vim: ts=2 sw=2 et

if [ ! -d "/home/container/steamcmd" ]; then
	echo Installing steamcmd
	mkdir -p /home/container/steamcmd
	curl -sSL -o /tmp/steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
	tar -xf /tmp/steamcmd.tar.gz --directory /home/container/steamcmd
fi

HEADLESS_DIRECTORY="/home/container/install/Headless"

if [ "${SKIP_STEAM_UPDATE}" = "false" ]; then
  /home/container/steamcmd/steamcmd.sh +login ${STEAM_USER} ${STEAM_PASS} +force_install_dir /home/container/install +app_license_request 2519830 +app_update 2519830 -beta "headless" -betapassword "${BETA_CODE}" validate +quit
fi

exec $*

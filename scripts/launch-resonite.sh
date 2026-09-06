#!/bin/sh

rm -r /home/container/Headless/Data
rm -r /home/container/Headless/Cache
find /Logs -type f -name *.log -atime +${LOG_RETENTION:-30} -delete

cd /home/container/Headless/

if [ "${SERVER_IP}" != "" ]; then
	echo Populating engine config
	if [ "${QUIC_MIN_PORT}" != "" ] && [ "${QUIC_MAX_PORT}" != "" ]; then
		echo Port range specified
		envsubst < /tools/ConfigPortrange.json > /home/container/Headless/Config.json
	else
		echo Port range not specified
		envsubst < /tools/Config.json > /home/container/Headless/Config.json
	fi
fi

if [ "${ENABLE_MODS}" = "true" ]; then
	exec dotnet Resonite.dll -HeadlessConfig /Config/${CONFIG_FILE} -Logs /Logs/ -LoadAssembly Libraries/ResoniteModLoader.dll ${ADDITIONAL_ARGUMENTS}
else
	exec dotnet Resonite.dll -HeadlessConfig /Config/${CONFIG_FILE} -Logs /Logs/ ${ADDITIONAL_ARGUMENTS}
fi

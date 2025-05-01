#!/bin/sh

rm -r /home/container/Headless/Data
rm -r /home/container/Headless/Cache
find /Logs -type f -name *.log -atime +${LOG_RETENTION:-30} -delete

cd /home/container/Headless/

exec dotnet Resonite.dll -HeadlessConfig /Config/${CONFIG_FILE} -Logs /Logs/ ${ADDITIONAL_ARGUMENTS}

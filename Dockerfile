FROM	mcr.microsoft.com/dotnet/runtime:9.0-bookworm-slim

LABEL	author="Voxel Bone Cloud" maintainer="github@voxelbone.cloud"
LABEL org.opencontainers.image.source=https://github.com/voxelbonecloud/resonite-headless-docker
LABEL org.opencontainers.image.description="Docker image based on Debian Bookworm Slim image with dotnet8 for hosting Resonite Headless servers. Supports automatic modding of the Headless."
LABEL org.opencontainers.image.licenses=MIT-0
LABEL org.opencontainers.image.authors="Voxel Bone Cloud"

RUN	apt update \
	&& dpkg --add-architecture i386 \
	&& apt install curl git lib32gcc-s1 -y \
	&& groupadd -g 1000 container \
	&& useradd -u 1000 -g 1000 -m -d /home/container -s /bin/bash container

COPY	./scripts /scripts

RUN	chmod +x /scripts/*

USER	container
ENV	USER=container 
ENV	HOME=/home/container
ENV	DEBIAN_FRONTEND=noninteractive

WORKDIR	/home/container

STOPSIGNAL SIGINT

ENTRYPOINT ["/scripts/update-resonite.sh"]
CMD ["/scripts/launch-resonite.sh"]

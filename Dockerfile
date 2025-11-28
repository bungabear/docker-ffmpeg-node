ARG TARGETPLATFORM="linux/amd64"
ARG NODE_VERSION="v22.12.0"

FROM linuxserver/ffmpeg:latest AS builder

ARG TARGETPLATFORM 
ARG NODE_VERSION

RUN apt update \
    && apt install -y xz-utils \
    && rm -rf /var/lib/apt/lists/* \
    \
    && ARCH=$([ "$(echo ${TARGETPLATFORM} | cut -d/ -f2)" = "amd64" ] && echo "x64" || echo "arm64") \
    \
    && NODE_TARBALL="node-${NODE_VERSION}-linux-${ARCH}.tar.xz" \
    && URL="https://nodejs.org/dist/$NODE_VERSION/$NODE_TARBALL" \
    \
    && curl -SLO $URL \
    && tar -xvf $NODE_TARBALL -C /usr/local --strip-components=1 \
    && rm $NODE_TARBALL

CMD [ "sh" ]
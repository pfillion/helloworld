ARG VERSION_ALPINE=latest

FROM alpine:${VERSION_ALPINE}

# Build-time metadata as defined at https://github.com/opencontainers/image-spec
ARG DATE
ARG CURRENT_VERSION_MICRO
ARG COMMIT
ARG AUTHOR
LABEL \
    org.opencontainers.image.created=$DATE \
    org.opencontainers.image.url="https://hub.docker.com/r/pfillion/helloworld" \
    org.opencontainers.image.source="https://github.com/pfillion/helloworld" \
    org.opencontainers.image.version=$CURRENT_VERSION_MICRO \
    org.opencontainers.image.revision=$COMMIT \
    org.opencontainers.image.vendor="pfillion" \
    org.opencontainers.image.title="Helloworld" \
    org.opencontainers.image.description="Simple hello world app." \
    org.opencontainers.image.authors=$AUTHOR \
    org.opencontainers.image.licenses="MIT"

COPY bin /usr/bin
ENTRYPOINT [ "helloworld" ]
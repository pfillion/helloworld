FROM alpine:3.8

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="Helloworld" \
    org.label-schema.description="Simple hello world app." \
    org.label-schema.url="https://hub.docker.com/r/pfillion/helloworld" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/pfillion/helloworld" \
    org.label-schema.vendor="pfillion" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"

COPY bin /usr/bin
ENTRYPOINT [ "helloworld" ]
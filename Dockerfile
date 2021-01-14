FROM alpine:edge

RUN apk add ssss=0.5.6-r0 --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/edge/testing && \
    rm -rf /var/cache/apk/*

# Use `hadolint` to check this file:
#    $ docker run --rm -i hadolint/hadolint < Dockerfile

FROM alpine:latest

LABEL maintainer="Cesar Gaspar <rasec.rapsag@gmail.com>" \
    description="Simplest samba docker container." \
    version="1.2"

RUN apk --no-cache upgrade && \
    apk --no-cache add samba samba-common-tools && \
    mkdir /config /storage

COPY entrypoint.sh /

VOLUME /storage

EXPOSE 139/tcp 445/tcp

ENTRYPOINT ["sh", "/entrypoint.sh"]

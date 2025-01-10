FROM alpine:latest

LABEL maintainer="Cesar Gaspar <rasec.rapsag@gmail.com>" \
    description="Simplest samba docker container." \
    version="1.3"

RUN apk --no-cache upgrade && \
    apk --no-cache add samba samba-common-tools && \
    mkdir /config /storage

COPY entrypoint.sh /

VOLUME /storage

EXPOSE 445/tcp

HEALTHCHECK --interval=1m --timeout=20s \
    CMD smbclient -L \\localhost -U % -m SMB3

ENTRYPOINT ["sh", "/entrypoint.sh"]

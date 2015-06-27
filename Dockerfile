FROM alpine:3.2

MAINTAINER <docker@vsense.fr> (@vsense)

ENV VERSION 1.8.7

RUN apk --update add \
    openjdk7 \
    wget
    && mkdir /minecraft \
    && wget --no-check-certificate https://s3.amazonaws.com/Minecraft.Download/versions/$VERSION/minecraft_server.$VERSION.jar /minecraft/minecraft_server.jar \
    && adduser -D -h /minecraft -s /sbin/nologin minecraft \
    && chown -R minecraft:minecraft /minecraft \
    && apk del wget \
    && rm -rf /var/cache/apk/*

USER minecraft

VOLUME /minecraft

EXPOSE 25565

CMD ["java","-Xms1G","-Xmx1G","-jar","minecraft_server.jar","nogui"]

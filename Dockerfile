FROM renewdoit/docker-alpine-java:jdk8
MAINTAINER renewdoit

ENV LEIN_ROOT true
ENV BOOT_AS_ROOT yes
ENV BOOT_EMIT_TARGET no
ENV BOOT_VERSION 2.7.2
ENV BOOT_JVM_OPTIONS "-client -XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xverify:none -XX:-OmitStackTraceInFastThrow"

RUN \
    apk add --update curl && \
    rm -rf /var/cache/apk/*

RUN \
    cd /usr/local/bin; \
    curl -fsSLo lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein; \
    chmod a+x lein; \
    lein;
RUN \
    cd /usr/local/bin; \
    curl -fsSLo boot https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh; \
    chmod a+x boot; \ 
    boot web -s doesnt/exist repl -e '(System/exit 0)'; 

COPY profile.boot /root/.boot

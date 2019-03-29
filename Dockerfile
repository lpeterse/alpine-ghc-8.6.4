FROM 		alpine:3.9

WORKDIR     /opt

RUN         apk update \
            && apk add alpine-sdk \
            && addgroup root abuild

COPY        ghc .
COPY        stack-1.9.3-linux-x86_64-static.tar.gz .

RUN         abuild-keygen -a -i -n \
            && abuild -r -F \
            && apk add /root/packages/x86_64/ghc* \
            && tar xf stack-1.9.3-linux-x86_64-static.tar.gz \
            && cp stack-1.9.3-linux-x86_64-static.tar.gz/stack /usr/local/bin/ \
            && rm -rf stack* ghc* /root/packages*


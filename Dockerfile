FROM        alpine:3.9.2

ARG         STACKAGE_RESOLVER

WORKDIR     /opt

RUN         apk update \
            && apk add alpine-sdk \
            && addgroup root abuild

# Build GHC
COPY        ghc .
RUN         abuild-keygen -a -i -n \
            && abuild -r -F \
            && apk add /root/packages/x86_64/ghc*

# Install stack
COPY        stack-1.9.3-linux-x86_64-static.tar.gz .
RUN         tar xf stack-1.9.3-linux-x86_64-static.tar.gz \
            && cp stack-1.9.3-linux-x86_64-static/stack /usr/local/bin/ \
            && rm -rf stack* ghc* /root/packages* /opt/* /opt/.* 

WORKDIR     /root
ENV         PATH=/root/.local/bin:$PATH

RUN         mkdir .stack \
            && echo "system-ghc: true" > .stack/config.yml \
            && stack install amazonka --resolver=${STACKAGE_RESOLVER}


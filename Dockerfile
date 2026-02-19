#
# Dockerfile for shadowsocks-libev
#

FROM alpine:3.13
LABEL maintainer="xzl2021 <xzl2021#hotmail.com>"

WORKDIR /
RUN  set -ex \
     # Build environment setup
     && apk add --no-cache --virtual .build-deps \
          autoconf \
          automake \
          build-base \
          c-ares-dev \
          libcap \
          libev-dev \
          libtool \
          libsodium-dev \
          linux-headers \
          mbedtls-dev \
          pcre-dev \
          git \
     # Build & install
     && git clone https://github.com/shadowsocks/shadowsocks-libev.git /tmp/libev \
     && cd /tmp/libev \
     && git checkout v3.3.5 \
     && git submodule update --init --recursive \
     && ./autogen.sh \
     && ./configure --prefix=/usr --disable-documentation \
     && make install \
     && ls /usr/bin/ss-* | xargs -n1 setcap cap_net_bind_service+ep \
     && apk del .build-deps \
     # Runtime dependencies setup
     && apk add --no-cache \
          tzdata \
          nginx \
          ca-certificates \
          rng-tools \
          $(scanelf --needed --nobanner /usr/bin/ss-* \
          | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
          | sort -u) \
     && wget --no-check-certificate -O /usr/local/bin/kcptun https://raw.githubusercontent.com/xzl2021/docker-sslibev-kcptun/master/files/kcptun_server_linux_amd64 \
     && wget --no-check-certificate -O /config.json https://raw.githubusercontent.com/xzl2021/docker-sslibev-kcptun/master/files/config.json \
     && wget --no-check-certificate -O /kcptun.json https://raw.githubusercontent.com/xzl2021/docker-sslibev-kcptun/master/files/kcptun.json \
     && wget --no-check-certificate -O /usr/local/bin/sslibev-kcptun https://raw.githubusercontent.com/xzl2021/docker-sslibev-kcptun/master/files/sslibev-kcptun.sh \
     && chmod +x /usr/local/bin/kcptun /usr/local/bin/sslibev-kcptun \
     && cd / \
     && rm -rf /tmp/*

VOLUME /etc/shadowsocks-libev
ENV TZ=Asia/Shanghai

CMD ["sslibev-kcptun"]

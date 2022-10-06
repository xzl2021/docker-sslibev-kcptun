#!/bin/bash
mkdir -p /etc/shadowsocks-libev-kcptun/
docker run -d -p 0.0.0.0:9443:443/udp -p 0.0.0.0:9444:444/udp -v /etc/shadowsocks-libev-kcptun:/etc/shadowsocks-libev --restart=always --name ss-kcp sslibev-kcptun:latest

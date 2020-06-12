#!/bin/bash
mkdir -p /etc/shadowsocks-libev-kcptun/
docker run -d -p 9443:443/udp -p 9444:444/udp -v /etc/shadowsocks-libev-kcptun:/etc/shadowsocks-libev --restart=always --name ss-kcp sslibev-kcptun:latest

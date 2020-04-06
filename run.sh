#!/bin/bash
mkdir -p /etc/shadowsocks-libev/
docker run -d -p 8443:443/udp -p 8444:444/udp -v /etc/shadowsocks-libev:/etc/shadowsocks-libev --restart=always --name ss-libev sslibev-kcptun:latest

#!/bin/sh
if [ ! -f /etc/shadowsocks-libev/config.json ]; then
	cp /config.json /etc/shadowsocks-libev/config.json
fi

if [ ! -f /etc/shadowsocks-libev/kcptun.json ]; then
	cp /kcptun.json /etc/shadowsocks-libev/kcptun.json
fi

ss-server -v -c /etc/shadowsocks-libev/config.json -f /var/run/shadowsocks-libev.pid || exit 1
kcptun -c /etc/shadowsocks-libev/kcptun.json || exit 1

while true
do
    sleep 1
done

#!/bin/sh
if [ ! -f /etc/shadowsocks-libev/config.json ]; then
	cp /config.json /etc/shadowsocks-libev/config.json
fi

/usr/bin/ss-server -v -c /etc/shadowsocks-libev/config.json -f /var/run/shadowsocks-libev.pid
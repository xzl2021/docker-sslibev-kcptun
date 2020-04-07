#!/bin/sh
if [ ! -f /etc/shadowsocks-libev/config.json ]; then
	cp /config.json /etc/shadowsocks-libev/config.json
fi

ss-server -v -c /etc/shadowsocks-libev/config.json -f /var/run/shadowsocks-

while true
do
    sleep 1
done

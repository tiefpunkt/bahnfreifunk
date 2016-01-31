i#!/bin/sh
OUT=$(curl -s -k "http://ice.portal2/jetty/api/v1/tripInfo")

if [ $? -ne 0 ]; then
	echo "no network :("
	exit 1
fi

iw dev wlan0 info | grep -q bahn.freifunk.net

if [ $? -eq 0 ]; then
	IF_LAN="wlan0"
	IF_WAN="wlan1"
else
	IF_LAN="wlan1"
	IF_WAN="wlan0"
fi

TRAIN_TYPE=$(echo "$OUT" | egrep -o '"trainType":"[A-Z]*"')
TRAIN_NO=$(echo "$OUT" | egrep -o '"vzn":"[0-9]*"')
CLIENTS=$(iw dev $IF_LAN station dump | grep Station | wc -l)
RX_BYTES=$(cat /sys/class/net/$IF_WAN/statistics/rx_bytes)
TX_BYTES=$(cat /sys/class/net/$IF_WAN/statistics/tx_bytes)

DATA="{ $TRAIN_TYPE, $TRAIN_NO, \"clients\":\"$CLIENTS\", \"rx_bytes\":\"$RX_BYTES\", \"tx_bytes\":\"$TX_BYTES\"}"

curl -s -k -X POST -d "$DATA" http://data.tiefpunkt.com/freifunk/status.php


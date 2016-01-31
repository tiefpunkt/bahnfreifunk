#!/bin/sh
nslookup hotspot.t-mobile.net > /dev/null
if [ $? -ne 0 ]; then
	echo "can't resolve hotspot.t-mobile.net. probably not a telekom hotspot. exit"
	exit 1
fi
echo "probably a hotspot"

OUT=$(curl -s -k -X POST -d '{"location":{},"user":{},"session":{},"partnerRegRequest":{}}' --header "Content-Type: application/json;charset=utf-8" https://hotspot.t-mobile.net/wlan/rest/contentapi)

if [ $? -ne 0 ]; then
	echo "can't get status"
	exit 1
fi

echo "$OUT" | grep -q '"wlanLoginStatus":"online"'

if [ $? -eq 0 ]; then
	echo "already online"
	exit 0
fi

echo "$OUT" | grep -q '"venueType":"ForFree"'

if [ $? -ne 0 ]; then
	echo "not for free, can't login"
	exit 0
fi

OUT=$(curl -s -k -X POST -d '{"location":{},"user":{},"session":{},"partnerRegRequest":{}}' --header "Content-Type: application/json;charset=utf-8" https://hotspot.t-mobile.net/wlan/rest/freeLogin)

if [ $? -ne 0 ]; then
	echo "login failed :("
	exit 0
fi

echo "$OUT" | grep -q '"wlanLoginStatus":"online"'

if [ $? -eq 0 ]; then
	echo "and we are online :)"
	exit 0
fi


#!/bin/sh

PROFILE="TLMR3020"
PACKAGES="kmod-rt2800-lib kmod-rt2800-usb kmod-rt2x00-lib kmod-rt2x00-usb curl -ppp -ppp-mod-pppoe"

IMAGEBUILDER_DIR=imagebuilder

downloadImagebuilder() {
	wget https://downloads.openwrt.org/chaos_calmer/15.05/ar71xx/generic/OpenWrt-ImageBuilder-15.05-ar71xx-generic.Linux-x86_64.tar.bz2
	if [ $? -ne 0 ]; then
		echo "Couldn't download image builder. Exiting"
		exit 1
	fi
	tar -xjf OpenWrt-ImageBuilder-15.05-ar71xx-generic.Linux-x86_64.tar.bz2
	mv OpenWrt-ImageBuilder-15.05-ar71xx-generic.Linux-x86_64 $IMAGEBUILDER_DIR
}

if [ ! -d "$IMAGEBUILDER_DIR" ]; then
	echo "Image builder not found. Downloading..."
	downloadImagebuilder
fi

make -C ./$IMAGEBUILDER_DIR/ image PROFILE=$PROFILE PACKAGES="$PACKAGES" FILES=../files/

if [ $? -ne 0 ]; then
	echo "Imagebuilder failed"
	exit 1
fi

echo "Done. You can find your images in imagebuilder/bin/ar71xx/"

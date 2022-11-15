#!/bin/bash

## download and unzip the SDK
OPENWRT_VERSION="22.03.2"
TARGET="ramips"
SUBTARGET="mt76x8"
URL="https://downloads.openwrt.org/releases/$OPENWRT_VERSION/targets/$TARGET/$SUBTARGET"
FILE="openwrt-sdk-$OPENWRT_VERSION-$TARGET-${SUBTARGET}_gcc-11.2.0_musl.Linux-x86_64"
ZIP="${FILE}.tar.xz"
NEWNAME="openwrt-sdk-$OPENWRT_VERSION"

# remove previously configured sdk
rm -rf $NEWNAME

if [ ! -e ./$ZIP ]; then
    curl $URL/$ZIP -O
    retval=$?
    if [ $retval -ne 0 ]; then
        echo "ERROR downloading SDK"
        exit 1
    fi
fi

tar -xf $ZIP
mv $FILE $NEWNAME


## add our custom repos as a package feed
cat config/new.feeds.conf >> $NEWNAME/feeds.conf.default

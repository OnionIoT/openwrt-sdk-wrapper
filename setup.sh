#!/bin/bash

## download and unzip the SDK
URL="https://downloads.openwrt.org/releases/21.02.1/targets/ramips/mt76x8"
FILE="openwrt-sdk-21.02.1-ramips-mt76x8_gcc-8.4.0_musl.Linux-x86_64"
ZIP="${FILE}.tar.xz"
NEWNAME="openwrt-sdk"

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
cat config/onion.feeds.conf >> $NEWNAME/feeds.conf.default

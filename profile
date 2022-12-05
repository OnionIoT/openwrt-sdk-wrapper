#!/bin/sh

OPENWRT_VERSION="22.03.2"
TARGET="ramips"
SUBTARGET="mt76x8"

BASE_URL="https://downloads.openwrt.org/releases/$OPENWRT_VERSION/targets/$TARGET/$SUBTARGET"

IMAGE_BUILDER_FILE="openwrt-imagebuilder-$OPENWRT_VERSION-$TARGET-$SUBTARGET.Linux-x86_64.tar.xz"
IMAGE_BUILDER_URL="$BASE_URL/$IMAGE_BUILDER_FILE"

SDK_FILE="openwrt-sdk-$OPENWRT_VERSION-$TARGET-${SUBTARGET}_gcc-11.2.0_musl.Linux-x86_64.tar.xz"
SDK_URL="$BASE_URL/$SDK_FILE"

## specify ipk repos to be included in the firmware (each repo in new line) 
PACKAGE_REPOS="
src/gz onion files:///media/Data/Source/gitrepo/OnionIoT/openwrt-sdk-wrapper/build/openwrt-22.03.2/ramips/mt76x8/sdk/bin/packages/mipsel_24kc/onion/
"

## specify package feeds to be included in sdk (each feed in new line)
PACKAGE_FEEDS="
src-git onion https://github.com/OnionIoT/OpenWRT-Packages.git;openwrt-22.03
"

## specify packages to be included in the firmware (each package in new line)
IMAGE_BUILDER_PACKAGES="
onion-repo-keys
omega2-base
omega2-base-files
omega2-base-passwd
"

SDK_PACKAGES="
onion-repo-keys
omega2-base
"

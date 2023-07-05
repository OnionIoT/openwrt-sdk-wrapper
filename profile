#!/bin/sh

# Stable OpenWrt Release version (Needs change whenever new openwrt release is available)
OPENWRT_VERSION="22.03.5"
TARGET="ramips"
SUBTARGET="mt76x8"

# Default base URL from where openwrt SDKs are available for the respective openwrt version and targets
BASE_URL="http://downloads.onioniot.com.s3.amazonaws.com/releases/$OPENWRT_VERSION/targets/$TARGET/$SUBTARGET"

# SDK file name available and downloaded from BASE_URL ((Needs change whenever new openwrt release is available with different gcc version))
SDK_FILE="openwrt-sdk-$OPENWRT_VERSION-$TARGET-${SUBTARGET}_gcc-11.2.0_musl.Linux-$(uname -p).tar.xz"
SDK_URL="$BASE_URL/$SDK_FILE"

# Keys directory to sign compiled packages, Ensure you have key-build files in specificed directory
KEYS_DIR="$PWD/keys"

## specify package feeds to be included in sdk (each feed in new line)
PACKAGE_FEEDS="
src-git onion https://github.com/OnionIoT/OpenWRT-Packages.git;openwrt-22.03
"

# Packages to be compiled by default (each package in new line. This would directory name containing Makefile of respective package)
# Each package in a new line
SDK_PACKAGES="
onion-repo-keys
omega2-base
omega2-ctrl
"

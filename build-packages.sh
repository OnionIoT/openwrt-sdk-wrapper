#!/bin/bash

DIRNAME="openwrt-sdk"

sdkSetup () {
    export LC_ALL=C

    # TODO: 
    ## copy over the repo keys
    #cp scripts/sdk/key-build* $DIRNAME/

    ## setup the SDK feeds
    cd $DIRNAME

    ./scripts/feeds update -a
    ./scripts/feeds install -a

    ## setup the SDK to compile the packages selected in our config file
    cp ../config .config
    make defconfig

    cd -
}

buildPackages () {
    cd $DIRNAME
    make

    if [ $? -ne 0 ]; then
        echo "ERROR during package compilation!"
        make -j1 V=s
        echo "ERROR during package compilation! See logs above"
        exit 1
    fi
}


###############################################################

sdkSetup
buildPackages

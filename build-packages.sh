#!/bin/bash

COMPILATION_ERROR=0
DIRNAME="openwrt-sdk"
TARGET_PACKAGE="all"

if [ "$1" != "" ]; then
  TARGET_PACKAGE="$1"
fi

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
    # TODO: test if copying over config file is necessary
    #cp ../config/config .config
    ## refresh the package config (selects all packages for compilation)
    make defconfig

    cd -
}

compilePackage () {
  pkgName="$1"
  make package/$pkgName/compile

  retval=$?
  if [ $retval -ne 0 ]; then
    make package/$pkgName/compile V=99
    COMPILATION_ERROR=1
    echo "\n>> ERROR: Compile of package ${pkgName} returned code $retval"
  fi
}

compileAllPackages () {
    compilePackage omega2-base
    compilePackage onion-repo-keys
}


###############################################################

sdkSetup
cd $DIRNAME

# compile
if [ "$TARGET_PACKAGE" = "all" ]; then
  compileAllPackages
else
  compilePackage "$TARGET_PACKAGE"
fi

# last step
if [ $COMPILATION_ERROR -ne 0 ]; then
    echo "\n>> PACKAGE COMPILATION ERROR!\n"
    exit 1
else
    echo "> Compile success"
fi

# TODO
# sign packages
# if [ "$TARGET_PACKAGE" = "all" ]; then
#     make package/index
# fi

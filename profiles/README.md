# SDK Profile Configuration

SDK profiles are managed in profiles directory. You can copy any profiles file to repo root directory to profile file name.

i.e

`profiles/default` is default profile template configuration. To use `default` profiles template.

`cp profiles/default` profile

## Environment Variables

profile file has predefined env variables which are being used in `onion_buildenv` script to manage all its actions.

|Variable|Default Value|Description|
|--------|-------------|-----------|
|OPENWRT_VERSION|22.03.2|OpenWrt Release Version|
|TARGET|ramips|SDK to compile packages for target|
|SUBTARGET|mt76x8|SDK to compile packages for subtarget|
|BASE_URL|https://downloads.openwrt.org/releases/$OPENWRT_VERSION/targets/$TARGET/$SUBTARGET|Root URL of SDK for specificed target and subtarget|
|SDK_FILE|openwrt-sdk-$OPENWRT_VERSION-$TARGET-${SUBTARGET}_gcc-11.2.0_musl.Linux-$(uname -p).tar.xz|SDK file to be downloaded from BASE_URL|
|SDK_URL|$BASE_URL/$SDK_FILE|Full SDK download URL|
|KEYS_DIR|$PWD/keys|Location of package signing keys|
|PACKAGE_FEEDS|src-git onion https://github.com/OnionIoT/OpenWRT-Packages.git;openwrt-22.03|Append lines to `feeds.conf` in the downloaded OpenWRT SDK|
|SDK_PACKAGES|onion-repo-keys omega2-base|Packages to be compiled by default|

## Onion SDK Build Environment

profile file is used with `onion_buildenv` script. `onion_buildenv` is all in one script that make build process simply and customization can be done in profile file only.
`onion_buildenv` provides few subcommands that can be used to setup sdk and compile packages.

|subcommand|Description|
|----------|-----------|
|onion_buildenv setup_sdk|Download and setup SDK with feeds|
|onion_buildenv update_sdk|Update feeds If SDK is already setup before|
|onion_buildenv clean_sdk|Cleanup SDK from local directory|
|onion_buildenv list_packages|List all available packages, Internally it uses `./scripts/feeds list|
|onion_buildenv build_packages <pkg1> .. <pkgN>|Build all packages passed in argument|
|onion_buildenv build_all_packages|Build all packages specified in SDK_PACKAGES|
|onion_buildenv index_packages|Sign SDK_PACKAGES with key|

## Use custom feed for local/alternative development

During development, there might be a need to pull package makefiles from a local source.

In that case, change the value of PACKAGE_FEEDS

```
PACKAGE_FEEDS="
src-link custom <FEED-DIRECTORY-HERE>
"
```

And run the `onion_buildenv update_sdk` script again.

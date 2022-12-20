# OpenWRT SDK Wrapper

Supporting scripts and config to **easily build OpenWRT packages using the [OpenWRT SDK](https://openwrt.org/docs/guide-developer/toolchain/using_the_sdk)**

# How to use this Repo

> By default, this repo is setup to build OpenWRT packages (based on source code in a Git repo) for deployment.

1. Run `bash onion_buildenv setup_sdk` to download and setup the OpenWRT SDK
2. Two options here:
  1. Run `bash onion_buildenv build_all_packages` to build all packages listed in the `SDK_PACKAGES` variable in `profile`
  1. Run `bash onion_buildenv build_packages <pkg1> <pkg2> ... <pkgN>` to build the specified packages
3. Find compiled package ipk files at `openwrt-sdk/bin/packages/mipsel_24kc/onion`

## Details

The `bash onion_buildenv setup_sdk` command:

- Will download and setup the OpenWRT SDK
- Add the custom feeds specified as env variable `PACKAGE_FEEDS` in a build `profile` to the SDK

The `bash onion_buildenv build_packages <pkg1> <pkg2> ... <pkgN>` command:

- Will compile the packages in the `<pkg1> <pkg2> ... <pkgN>` arguments

The `bash onion_buildenv build_all_packages` command:

- Will compile all the packages specified as env variable `SDK_PACKAGES` in a build `profile` to the SDK
- Will build a package index signed with the keys in the [`keys/` directory](./keys) (learn more about package signing [here](https://openwrt.org/docs/guide-user/security/release_signatures) and [here](https://openwrt.org/docs/guide-developer/toolchain/using_the_sdk))
- All output will be in the `openwrt-sdk/bin/packages/mipsel_24kc/onion` directory

---

# Using this Repo for Development

By default, the packages are built from source code in git repo specified as env variable `PACKAGE_FEEDS` in a build profile to SDK.

While your packages are still under development and you are iterating on the package source code, it will be more straight-forward to work from a **local copy** of the package source instead.

To work from a local copy of your source code:

1. Clone your package source code repo to your development machine
2. Update env variable `PACKAGE_FEEDS` in a `profile` to the local source. See [profiles/README.md](./profiles/README.md) for details.
3. Make any changes to the package source code
4. Run `bash onion_buildenv setup_sdk` to download and setup the OpenWRT SDK
5. Run `bash onion_buildenv build_packages <pkg1> <pkg2> ... <pkgN>` to build the desired packages
6. Find your compiled packages in the `openwrt-sdk/bin/packages/mipsel_24kc/<feed>/` directory
7. Test compiled packages on the device. If more code changes are required, start again from step 3.


## Example

If we wanted to build the packages from the Onion OpenWRT-Packages repo for development, the steps would be as follows:

1. clone your package source code repo to your development machine
    * Clone the repo: `git clone https://github.com/OnionIoT/OpenWRT-Packages.git` **note the path to the cloned directory**, in our case it's `/home/ubuntu/OpenWRT-Packages`
    * Checkout desired branch if required
2. Update env variable `PACKAGE_FEEDS` in a `profile`:
    * set a value: `PACKAGE_FEEDS="src-link custom /home/ubuntu/OpenWRT-Packages"`, since `/home/ubuntu/OpenWRT-Packages` is the absolute path to the cloned directory from step 1
3. Make any changes to the package source files in `/home/ubuntu/OpenWRT-Packages`
4. Run `bash onion_buildenv setup_sdk` to download and setup the OpenWRT SDK
5. Run `bash onion_buildenv build_packages` to build the desired packages
6. Find the compiled packages in the `openwrt-sdk/bin/packages/mipsel_24kc/custom/` directory

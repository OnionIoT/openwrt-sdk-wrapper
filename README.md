# OpenWRT SDK Wrapper

Supporting scripts and config to **easily build OpenWRT packages using the [OpenWRT SDK](https://openwrt.org/docs/guide-developer/toolchain/using_the_sdk)**

# How to use this Repo

> By default, this repo is setup to build OpenWRT packages (based on source code in a Git repo) for deployment. 

1. Run `bash setup.sh` to download and setup the OpenWRT SDK
2. Run `bash build-packages.sh` to build the desired packages
3. Find compiled package ipk files at `openwrt-sdk/bin/packages/mipsel_24kc/onion`

## Details

The `setup.sh` script:

- Will download and setup the OpenWRT SDK
- Add the custom feeds specified in `config/new.feeds.conf` to the SDK

The `build.sh` script:

- Will compile the specified packages and build a package index signed with the keys in the [`keys` directory](./keys) (learn more about package signing [here](https://openwrt.org/docs/guide-user/security/release_signatures) and [here](https://openwrt.org/docs/guide-developer/toolchain/using_the_sdk))
- All output will be in the `openwrt-sdk/bin/packages/mipsel_24kc/onion` directory
- The `compileAllPackages` function in the script specifies which packages will be compiled

---

# Using this Repo for Development

By default, the packages are built from source code in git repo specified in `config/new.feeds.conf`.

While your packages are still under development and you are iterating on the package source code, it will be more straight-forward to work from a **local copy** of the package source instead.

To work from a local copy of your source code:

1. Clone your package source code repo to your development machine
2. Update `config/new.feeds.conf` to point to the local source. See [`config/README.md`](./config/README.md) for details.
3. Make any changes to the package source code
4. Run `bash setup.sh` to download and setup the OpenWRT SDK
5. Run `bash build-packages.sh` to build the desired packages
6. Find your compiled packages in the `openwrt-sdk/bin/packages/mipsel_24kc/custom/` directory
7. Test compiled packages on the device. If more code changes are required, start again from step 3.
        
        
## Example

If we wanted to build the packages from the Onion OpenWRT-Packages repo for development, the steps would be as follows:

1. clone your package source code repo to your development machine
    * Clone the repo: `git clone https://github.com/OnionIoT/OpenWRT-Packages.git` **note the path to the cloned directory**, in our case it's `/home/ubuntu/OpenWRT-Packages`
    * Checkout desired branch if required
2. Update `config/new.feeds.conf`: 
    * comment out the `src-git` line
    * add a line: `src-link custom /home/ubuntu/OpenWRT-Packages`, since `/home/ubuntu/OpenWRT-Packages` is the absolute path to the cloned directory from step 1
3. Make any changes to the package source files in `/home/ubuntu/OpenWRT-Packages`
4. Run `bash setup.sh` to download and setup the OpenWRT SDK
5. Run `bash build-packages.sh` to build the desired packages
6. Find the compiled packages in the `openwrt-sdk/bin/packages/mipsel_24kc/custom/` directory

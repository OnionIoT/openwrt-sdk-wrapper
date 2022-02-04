# SDK Feed Configuration

> The `setup.sh` script will append what's in the `onion.feeds.conf` file to the feed configuration file in the downloaded OpenWRT SDK.

Have two options when specifying feeds for the SDK:

1. Point to an online package repository (like a GitHub Repo)
2. Point to a local package repository

## Default: Point to online package repository

By default, the `onion.feeds.conf` file will point to the OnionIoT/OpenWRT-Packages repo on GitHub.

This is useful for Continuous Integration.

## Alternative for Development

During development, there might be a need to pull package makefiles from a local source.

In that case, change the contents of `onion.feeds.conf` to:

```
src-link custom <FEED-DIRECTORY-HERE>
```

And run the `setup.sh` script again.
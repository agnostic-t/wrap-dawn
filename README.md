# Axle Wrapper for dawn library

> Original repository: [google/dawn](https://github.com/google/dawn)

This repository is *only* a wrapper for release of dawn library. No code was written by author of this repository.

Created especially for [axle](https://github.com/agnostic-t/axle) build system.

## Before using

This repo contains pre-build script, that builds dawn from sources, therefore install build dependencies beforehand (`fetch_dawn_dependencies` will be called anyways)

## How to use

In order to use this module, in your `module.json`:

```json
{
  "remote_deps": {
    "dawn": {
      "version": ">=0.0.0",
      "url": "https://github.com/agnostic-t/wrap-dawn"
    }
  },
}
```

In dependencies of modules:

```json
{
  "dependencies": {
    "dawn": { "version": ">=0.0.0" }
  }
}
```

#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
VERSION="3.1.0"

SOURCE_DIR="$ROOT/.src/dawn"
BUILD_DIR="$ROOT/.build/dawn"
INSTALL_DIR="$ROOT/.modules/dawn"

rm -rf "$SOURCE_DIR"
rm -rf "$BUILD_DIR"
rm -rf "$INSTALL_DIR/include"
rm -rf "$INSTALL_DIR/bin"

mkdir -p "$ROOT/.src"
mkdir -p "$ROOT/.build"
mkdir -p "$INSTALL_DIR"

git clone \
    --depth 1 \
    https://dawn.googlesource.com/dawn \
    "$SOURCE_DIR"

python "$SOURCE_DIR/tools/fetch_dawn_dependencies.py"

mkdir -p "$SOURCE_DIR/out/Debug"
(cd "$SOURCE_DIR/out/Debug" && cmake ../.. && make)

echo
echo "Dawn installed into:"
echo "  $INSTALL_DIR"

echo

rm -rf "$BUILD_DIR"
rm -rf "$SOURCE_DIR"

#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."

SOURCE_DIR="$ROOT/.src/dawn"
BUILD_DIR="$ROOT/.build/dawn"
INSTALL_DIR="$ROOT/.modules/dawn"

rm -rf "$SOURCE_DIR" "$BUILD_DIR"
rm -rf "$INSTALL_DIR/include" "$INSTALL_DIR/lib" "$INSTALL_DIR/bin"
mkdir -p "$ROOT/.src" "$ROOT/.build" "$INSTALL_DIR"

git clone --depth 1 https://dawn.googlesource.com/dawn "$SOURCE_DIR"

python "$SOURCE_DIR/tools/fetch_dawn_dependencies.py" -d "$SOURCE_DIR"

test -f "$SOURCE_DIR/third_party/abseil-cpp/CMakeLists.txt" || {
    echo "ERROR: Dawn deps were not fetched (fetch script fails silently)" >&2
    exit 1
}

cmake -S "$SOURCE_DIR" -B "$BUILD_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DDAWN_FETCH_DEPENDENCIES=ON \
    -DDAWN_ENABLE_INSTALL=ON \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
    -DDAWN_BUILD_SAMPLES=OFF \
    -DDAWN_BUILD_TESTS=OFF \
    -DDAWN_BUILD_BENCHMARKS=OFF \
    -DDAWN_BUILD_NODE_BINDINGS=OFF

cmake --build "$BUILD_DIR" -j "$(nproc)"
cmake --install "$BUILD_DIR"

echo
echo "Dawn installed into: $INSTALL_DIR"

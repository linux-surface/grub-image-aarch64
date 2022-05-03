#!/bin/sh
set -e

echo "-- BUILDING CONTAINER ----------------------------------------------------------"
docker build . -t aarch64-grub
echo ""
echo "-- GENERATING IMAGE ------------------------------------------------------------"
docker run --rm                     \
    -v "${PWD}/":/output            \
    aarch64-grub                    \
    aarch64-grub-mkimage            \
        -O arm64-efi                \
        -o /output/bootaa64.efi     \
        --prefix=                   \
        $(cat modules.txt)
echo "done: wrote image to '${PWD}/bootaa64.efi'"

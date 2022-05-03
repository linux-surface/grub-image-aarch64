# GRUB AArch64 Image for Surface Pro X

Docker container to build a (self-contained) GRUB AArch64 image for the Surface Pro X on a host with different architecture (e.g. x86).


## Basic Instructions

To build the container (named `aarch64-grub`) and a known-good image simply run `./mkimage.sh` from this directory.


## Manual Instructions

To build the container, run
```sh
docker build . -t grub-aarch64
```
where `grub-aarch64` is an arbitrary container name.

To run arbitrary grub commands run
```sh
docker run [docker options...] grub-aarch64 <command> [command options...]
```
Note that you have to prefix the standard `grub` commands with `aarch64-`.
For example, to generate a fully self-contained image in the current directory, run
```sh
docker run --rm                     \
    -v "${PWD}/":/output            \
    grub-aarch64                    \
    aarch64-grub-mkimage            \
        -O arm64-efi                \
        -o /output/bootaa64.efi     \
        --prefix=                   \
        $(cat modules.txt)
```


## Pre-Built Container

A prebuilt container that can be used with the manual instructions above can be obtained via
```sh
docker pull ghcr.io/linux-surface/grub-aarch64:latest
```

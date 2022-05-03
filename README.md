# GRUB AArch64 Image for Surface Pro X

Docker container to build a (self-contained) GRUB AArch64 image for the Surface Pro X on a host with different architecture (e.g. x86).


## Basic Instructions

To build the container (named `aarch64-grub`) and a known-good image simply run `./mkimage.sh` from this directory.

## Manual Instructions

To build the container, run
```
docker build . -t aarch64-grub
```
where `aarch64-grub` is an arbitrary container name.

To run arbitrary grub commands run
```sh
docker run [docker options...] aarch64-grub <command> [command options...]
```
Note that you have to prefix the standard `grub` commands with `aarch64-`.
For example, to generate a fully self-contained image in the current directory, run
```sh
docker run --rm                     \
    -v "${PWD}/":/output            \
    aarch64-grub                    \
    aarch64-grub-mkimage            \
        -O arm64-efi                \
        -o /output/bootaa64.efi     \
        --prefix=                   \
        $(cat modules.txt)
```
